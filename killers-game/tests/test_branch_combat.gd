extends SceneTree

var failures: int = 0
var arena
var player
var bot


func _initialize() -> void:
	_run.call_deferred()


func _frames(count: int) -> void:
	for index in count:
		await physics_frame


func _check(condition: bool, description: String) -> void:
	if condition:
		print("PASS: ", description)
	else:
		failures += 1
		push_error(description)


func _place_pair(player_position: Vector3 = Vector3(0, 0, 10), bot_position: Vector3 = Vector3(0, 0, 8.6)) -> void:
	player.global_position = player_position
	bot.global_position = bot_position
	player.rotation = Vector3.ZERO
	player.camera.rotation = Vector3.ZERO
	await _frames(3)


func _fresh_hunter() -> void:
	arena.combat_settings.hiding_seconds = 0.0
	arena.start_training(&"hunter")
	await _place_pair()


func _run() -> void:
	arena = load("res://scenes/practice_arena.tscn").instantiate()
	arena.combat_settings = arena.combat_settings.duplicate()
	root.add_child(arena)
	current_scene = arena
	await _frames(30)
	player = arena.player
	bot = arena.bot
	# Fixer les positions pour tester les règles de combat, sans promenade aléatoire.
	player.set_physics_process(false)
	bot.set_physics_process(false)
	arena.start_training(&"hunter")
	_check(arena.survivor_lives == 3 and arena.hiding_remaining == 30.0, "Defaults give three lives and thirty seconds to hide")
	_check(not player.controls_active and bot.active and not bot.visible, "Hunter waits while the hidden survivor can move")
	_check(not arena.request_player_attack(), "Cannot attack during hiding")
	_check(arena.player_weapon.visible and not arena.bot_weapon.visible, "Only the hunter carries the branch")
	await _frames(1802)
	_check(arena.hiding_remaining == 0.0 and player.controls_active and bot.visible, "Hiding ends and releases the hunter")
	await _place_pair()
	var click := InputEventMouseButton.new()
	click.button_index = MOUSE_BUTTON_LEFT
	click.pressed = true
	arena._unhandled_input(click)
	_check(not arena.player_weapon.attacking, "Left click no longer attacks")
	var attack_key := InputEventKey.new()
	attack_key.keycode = KEY_X
	attack_key.pressed = true
	attack_key.echo = true
	arena._unhandled_input(attack_key)
	_check(not arena.player_weapon.attacking, "Key repeat does not start an attack")
	attack_key.echo = false
	arena._unhandled_input(attack_key)
	_check(arena.player_weapon.attacking, "X starts the branch swing")
	await _frames(8)
	_check(arena.survivor_lives == 3, "Windup gives the survivor time to dodge")
	await _frames(12)
	_check(arena.survivor_lives == 2, "One successful swing removes exactly one life")
	_check(arena.hiding_remaining > 29.0 and not player.controls_active, "A lost life starts another hiding phase")
	_check(player.position.is_equal_approx(Vector3(0, 0.1, 10)) and bot.position.is_equal_approx(Vector3(3, 0.1, 6)), "Both players reset while remaining lives are preserved")
	_check(not arena.request_player_attack(), "No repeat damage during protection")
	arena._set_active(false)
	var countdown: float = arena.hiding_remaining
	await _frames(120)
	_check(is_equal_approx(arena.hiding_remaining, countdown), "Menu pauses the hiding countdown")
	_check(arena.get_node("HUD/Lives").text.contains("2 / 3"), "HUD reflects remaining lives")

	await _fresh_hunter()
	bot.position.z = 6.0
	await _frames(3)
	arena.request_player_attack()
	await _frames(20)
	_check(arena.survivor_lives == 3, "Out-of-range attacks miss")
	_check(not arena.request_player_attack(), "Cooldown prevents repeated attacks")
	await _frames(45)
	_check(arena.request_player_attack(), "Branch becomes available after cooldown")

	await _fresh_hunter()
	player.rotation.y = PI
	arena.request_player_attack()
	await _frames(20)
	_check(arena.survivor_lives == 3, "Targets behind the hunter are not hit")

	await _fresh_hunter()
	await _place_pair(Vector3(0, 0, 0.7), Vector3(0, 0, -0.7))
	arena.request_player_attack()
	await _frames(20)
	_check(arena.survivor_lives == 3, "Walls block branch damage")

	await _fresh_hunter()
	arena.request_player_attack()
	await _frames(8)
	bot.position.x = 5.0
	await _frames(15)
	_check(arena.survivor_lives == 3, "Leaving range during windup avoids the hit")

	await _fresh_hunter()
	arena.request_player_attack()
	arena._set_active(false)
	var windup: float = arena.player_weapon.windup_remaining
	await _frames(60)
	_check(arena.survivor_lives == 3 and is_equal_approx(arena.player_weapon.windup_remaining, windup), "Menu pauses a pending strike")
	arena._resume()
	await _frames(20)
	_check(arena.survivor_lives == 2, "Resuming completes the pending strike once")

	await _fresh_hunter()
	for remaining in [2, 1, 0]:
		await _place_pair()
		arena.request_player_attack()
		await _frames(65)
		_check(arena.survivor_lives == remaining, "Life count reaches %d" % remaining)
	_check(arena.finished and not arena.training_running and not player.controls_active and not bot.active, "Zero lives stops the training")
	_check(not arena.resume_button.visible and arena.reset_button.visible, "Defeat offers restart instead of resume")
	arena._resume()
	_check(not arena.training_running and not arena.request_player_attack(), "Finished training cannot resume or attack")
	arena._reset()
	_check(arena.survivor_lives == 3 and not arena.finished and arena.training_running, "Restart restores lives and clears defeat")

	arena.start_training(&"survivor")
	_check(not arena.request_player_attack() and not arena.player_weapon.visible and arena.bot_weapon.visible, "Survivor cannot use the hunter weapon")
	await _place_pair()
	await _frames(20)
	_check(arena.survivor_lives == 2, "Nearby hunter AI attacks the human survivor")

	arena.combat_settings.starting_lives = 5
	arena.combat_settings.branch_range = 0.6
	await _fresh_hunter()
	arena.request_player_attack()
	await _frames(20)
	_check(arena.survivor_lives == 5 and arena.get_node("HUD/Lives").text.contains("5 / 5"), "Lives and weapon range follow the configuration")
	print("Branch combat validation: ", failures, " failure(s)")
	quit(1 if failures else 0)
