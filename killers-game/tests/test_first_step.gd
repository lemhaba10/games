extends SceneTree
## Run with --headless --fixed-fps 60 --path killers-game --script res://tests/test_first_step.gd

var failures: int = 0


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


func _run() -> void:
	var arena = load("res://scenes/practice_arena.tscn").instantiate()
	arena.combat_settings = arena.combat_settings.duplicate()
	arena.combat_settings.hiding_seconds = 0.0
	root.add_child(arena)
	current_scene = arena
	var player = arena.get_node("Player")
	await _frames(30)
	_check(player.is_on_floor(), "The player rests on the floor")
	_check(absf(player.position.y) < 0.05, "Feet stay at floor height")
	_check(not player.controls_active, "The welcome screen starts with free mouse and no movement")

	arena.start_training(&"survivor")
	# Isoler les tests du contrôleur des collisions avec le personnage mobile.
	arena.bot.set_active(false)
	arena.bot.set_physics_process(false)
	arena.bot.collision_layer = 0
	Input.action_press("move_forward")
	await _frames(60)
	Input.action_release("move_forward")
	var forward_distance: float = 10.0 - player.position.z
	_check(forward_distance > 4.0 and forward_distance < 5.2, "Forward motion follows configured speed")

	player.reset_to_spawn()
	Input.action_press("move_forward")
	Input.action_press("move_right")
	await _frames(60)
	Input.action_release("move_forward")
	Input.action_release("move_right")
	var diagonal_distance: float = Vector2(player.position.x, player.position.z - 10.0).length()
	_check(absf(diagonal_distance - forward_distance) < 0.25, "Diagonal movement gives no speed advantage")

	player.reset_to_spawn()
	Input.action_press("move_forward")
	await _frames(240)
	Input.action_release("move_forward")
	_check(player.position.z > 0.63 and player.position.z < 0.75, "Central wall blocks the capsule")
	_check(player.camera.global_position.z > 0.6, "Camera stays outside the wall")

	player.reset_to_spawn()
	player.rotation.y = PI / 2.0
	Input.action_press("move_forward")
	await _frames(40)
	Input.action_release("move_forward")
	_check(player.position.x < -2.0 and absf(player.position.z - 10.0) < 0.1, "Movement follows camera heading")

	player.reset_to_spawn()
	Input.action_press("walk")
	Input.action_press("move_forward")
	await _frames(60)
	Input.action_release("walk")
	Input.action_release("move_forward")
	_check(10.0 - player.position.z < 2.7, "Walk modifier reduces movement speed")

	# Changing the resource must affect the actual controller, not only the UI.
	player.reset_to_spawn()
	player.settings = player.settings.duplicate()
	player.settings.run_speed = 2.0
	Input.action_press("move_forward")
	await _frames(60)
	Input.action_release("move_forward")
	_check(10.0 - player.position.z > 1.5 and 10.0 - player.position.z < 2.2, "Changing the resource changes movement speed")

	var mouse := InputEventMouseMotion.new()
	mouse.screen_relative = Vector2(0, 100000)
	player._unhandled_input(mouse)
	_check(absf(player.camera.rotation.x) <= deg_to_rad(player.settings.pitch_limit) + 0.001, "Vertical look is clamped")

	arena._set_active(false)
	var stopped_at: Vector3 = player.position
	Input.action_press("move_forward")
	await _frames(30)
	Input.action_release("move_forward")
	_check(player.position.distance_to(stopped_at) < 0.05, "Opening the menu stops movement")
	_check(Input.mouse_mode == Input.MOUSE_MODE_VISIBLE, "Menu releases the mouse")
	player.reset_to_spawn()
	_check(player.position.is_equal_approx(Vector3(0, 0.1, 10)), "Reset returns to spawn")
	_check(player.camera.rotation.is_zero_approx(), "Reset restores the view")

	player.position.y = -12.0
	await _frames(3)
	_check(player.position.y > -1.0, "Falling outside the map recovers the player")

	print("First step validation: ", failures, " failure(s)")
	quit(1 if failures else 0)
