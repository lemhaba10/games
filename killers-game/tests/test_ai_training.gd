extends SceneTree

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
	await _frames(30)
	var bot = arena.bot
	var player = arena.player
	var navigation = arena.navigation
	_check(navigation.ready_for_paths and navigation.free_cells.size() > 100, "Navigation builds from arena collisions")
	_check(not bot.active and not bot.visible, "Opponent waits for role selection")
	arena._set_active(true)
	_check(not player.controls_active, "Cannot bypass role selection")

	arena.survivor_button.pressed.emit()
	_check(player.role == &"survivor" and bot.role == &"hunter", "Survivor button assigns a hunter opponent")
	_check(bot.active and bot.visible and player.controls_active, "Role selection starts both characters")
	_check(is_equal_approx(bot.movement_speed(), player.settings.hunter_run_speed), "Hunter AI uses configured hunter speed")
	bot.rng.seed = 42
	var start: Vector3 = bot.position
	await _frames(120)
	_check(bot.position.distance_to(start) > 2.0, "Opponent moves autonomously")

	arena._set_active(false)
	var paused_position: Vector3 = bot.position
	await _frames(120)
	_check(bot.position.is_equal_approx(paused_position), "Menu freezes opponent movement")
	_check(not player.controls_active and Input.mouse_mode == Input.MOUSE_MODE_VISIBLE, "Menu releases player controls")

	arena.hunter_button.pressed.emit()
	_check(player.role == &"hunter" and bot.role == &"survivor", "Hunter button assigns a survivor opponent")
	_check(is_equal_approx(bot.movement_speed(), player.settings.run_speed), "Survivor AI uses configured survivor speed")
	_check(player.position.is_equal_approx(Vector3(0, 0.1, 10)), "Changing role resets the player")
	_check(bot.position.is_equal_approx(Vector3(3, 0.1, 6)), "Changing role resets the opponent")

	# A route must really pass around the central wall, not merely stop against it.
	bot.position = Vector3(0, 0.1, 6)
	bot.route = navigation.path_between(bot.position, Vector3(0, 0, -6))
	bot.waypoint = 0
	bot.pause_remaining = 0.0
	var went_around: bool = false
	var arrived: bool = false
	for frame in 420:
		await physics_frame
		went_around = went_around or absf(bot.position.x) >= 4.5
		if Vector2(bot.position.x, bot.position.z + 6.0).length() < 0.2:
			arrived = true
			break
	_check(arrived and went_around, "Opponent follows a route around the wall")

	# Observe two minutes of random walking, including corners and repeated destinations.
	bot.reset_to_spawn()
	bot.rng.seed = 17
	var capsule := CapsuleShape3D.new()
	capsule.radius = 0.30
	capsule.height = 1.6
	var query := PhysicsShapeQueryParameters3D.new()
	query.shape = capsule
	query.collision_mask = 1
	var safe: bool = true
	var travelled: float = 0.0
	var previous: Vector3 = bot.position
	var initial_destinations: int = bot.destinations_chosen
	for frame in 7200:
		await physics_frame
		travelled += bot.position.distance_to(previous)
		previous = bot.position
		if frame % 30 == 0:
			query.transform = Transform3D(Basis.IDENTITY, bot.global_position + Vector3(0, 0.95, 0))
			safe = safe and bot.get_world_3d().direct_space_state.intersect_shape(query, 1).is_empty()
			safe = safe and absf(bot.position.x) < 14.7 and absf(bot.position.z) < 14.7 and bot.position.y > -0.1
	_check(safe, "Random walking respects walls, floor and arena boundaries")
	_check(travelled > 100.0 and bot.destinations_chosen - initial_destinations >= 5, "Opponent keeps selecting new destinations without getting stuck")

	bot.ai_settings = bot.ai_settings.duplicate()
	bot.ai_settings.speed_multiplier = 0.5
	_check(is_equal_approx(bot.movement_speed(), player.settings.run_speed * 0.5), "AI speed multiplier is configurable")
	arena._reset()
	_check(bot.position.is_equal_approx(Vector3(3, 0.1, 6)) and bot.route.is_empty(), "Restart clears opponent route and restores spawn")
	_check(player.role == &"hunter" and bot.role == &"survivor", "Restart preserves selected roles")
	print("AI training validation: ", failures, " failure(s)")
	quit(1 if failures else 0)
