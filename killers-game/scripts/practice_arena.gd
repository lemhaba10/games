extends Node3D

@export var combat_settings: CombatSettings = preload("res://config/combat_settings.tres")

@onready var player: CharacterBody3D = $Player
@onready var bot: CharacterBody3D = $Bot
@onready var navigation: PracticeNavigation = $Navigation
@onready var player_weapon: BranchWeapon = $Player/Camera3D/Branch
@onready var bot_weapon: BranchWeapon = $Bot/Model/RightArm/Branch
@onready var overlay: Control = $HUD/Overlay
@onready var crosshair: Control = $HUD/Crosshair
@onready var resume_button: Button = $HUD/Overlay/Center/Card/Margin/Content/Resume
@onready var reset_button: Button = $HUD/Overlay/Center/Card/Margin/Content/Reset
@onready var survivor_button: Button = $HUD/Overlay/Center/Card/Margin/Content/Roles/Survivor
@onready var hunter_button: Button = $HUD/Overlay/Center/Card/Margin/Content/Roles/Hunter
@onready var heading: Label = $HUD/Overlay/Center/Card/Margin/Content/Heading

var has_selected_role: bool = false
var training_running: bool = false
var finished: bool = false
var survivor_lives: int = 0
var hiding_remaining: float = 0.0
var feedback_remaining: float = 0.0


func _ready() -> void:
	resume_button.pressed.connect(_resume)
	reset_button.pressed.connect(_reset)
	survivor_button.pressed.connect(start_training.bind(&"survivor"))
	hunter_button.pressed.connect(start_training.bind(&"hunter"))
	player_weapon.impact.connect(_resolve_attack.bind(player, bot))
	bot_weapon.impact.connect(_resolve_attack.bind(bot, player))
	bot.navigation = navigation
	survivor_button.disabled = true
	hunter_button.disabled = true
	_set_active(false)
	# Attendre l'enregistrement des collisions dans le serveur physique.
	await get_tree().physics_frame
	await get_tree().physics_frame
	navigation.build()
	survivor_button.disabled = not navigation.ready_for_paths
	hunter_button.disabled = not navigation.ready_for_paths
	survivor_button.grab_focus()


func start_training(role: StringName) -> void:
	if role not in [&"survivor", &"hunter"] or not navigation.ready_for_paths:
		return
	has_selected_role = true
	player.role = role
	bot.set_role(&"hunter" if role == &"survivor" else &"survivor")
	player_weapon.visible = role == &"hunter"
	bot_weapon.visible = role == &"survivor"
	$HUD/PlayerName.text = "Vous : Survivant  ·  IA : Chasseur" if role == &"survivor" else "Vous : Chasseur  ·  IA : Survivant"
	_reset()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if has_selected_role:
			_set_active(not training_running)
		get_viewport().set_input_as_handled()
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		request_player_attack()
	elif event.is_action_pressed("reset_position") and player.controls_active:
		player.reset_to_spawn()
		get_viewport().set_input_as_handled()


func request_player_attack() -> bool:
	if not training_running or finished or hiding_remaining > 0.0 or player.role != &"hunter":
		return false
	return player_weapon.try_attack()


func _physics_process(delta: float) -> void:
	if not training_running:
		return
	feedback_remaining = maxf(0.0, feedback_remaining - delta)
	if feedback_remaining == 0.0:
		$HUD/Feedback.text = ""
	if hiding_remaining > 0.0:
		hiding_remaining = maxf(0.0, hiding_remaining - delta)
		player_weapon.tick(delta)
		bot_weapon.tick(delta)
		_apply_controls()
		_update_hud()
		return
	player_weapon.tick(delta)
	if finished or hiding_remaining > 0.0:
		return
	bot_weapon.tick(delta)
	if finished or hiding_remaining > 0.0:
		return
	# L'IA garde ses déplacements aléatoires ; elle réagit seulement à courte portée.
	if bot.role == &"hunter" and not bot_weapon.attacking and bot_weapon.cooldown_remaining <= 0.0:
		if _can_hit(bot, player, false):
			var target := Vector3(player.global_position.x, bot.model.global_position.y, player.global_position.z)
			if bot.model.global_position.distance_to(target) > 0.01:
				bot.model.look_at(target)
			bot_weapon.try_attack()
	_apply_controls()
	_update_hud()


func _can_hit(attacker: CharacterBody3D, target: CharacterBody3D, check_aim: bool = true) -> bool:
	if attacker.role != &"hunter" or target.role != &"survivor":
		return false
	var origin: Vector3 = player.camera.global_position if attacker == player else bot.global_position + Vector3(0, 1.3, 0)
	var aim: Vector3 = -player.camera.global_basis.z if attacker == player else -bot.model.global_basis.z
	var target_point := target.global_position + Vector3(0, 1.1, 0)
	var offset := target_point - origin
	if offset.length() > combat_settings.branch_range or offset.length() < 0.001:
		return false
	if check_aim and aim.dot(offset.normalized()) < cos(deg_to_rad(combat_settings.branch_half_angle)):
		return false
	var query := PhysicsRayQueryParameters3D.create(origin, target_point, 3, [attacker.get_rid()])
	var result := get_world_3d().direct_space_state.intersect_ray(query)
	return not result.is_empty() and result.collider == target


func _resolve_attack(attacker: CharacterBody3D, target: CharacterBody3D) -> void:
	if not training_running or finished or hiding_remaining > 0.0:
		return
	# Recontrôler la cible à l'impact : elle peut avoir esquivé pendant la préparation.
	if not _can_hit(attacker, target):
		if attacker == player:
			_feedback("Coup manqué")
		return
	survivor_lives = maxi(0, survivor_lives - 1)
	_feedback("Touché ! Une vie en moins." if attacker == player else "Vous avez été touché ! Une vie en moins.")
	if survivor_lives == 0:
		finished = true
		_set_active(false)
	else:
		_begin_hiding()
	_update_hud()


func _begin_hiding() -> void:
	player.reset_to_spawn()
	bot.reset_to_spawn()
	player_weapon.cancel_swing()
	bot_weapon.cancel_swing()
	hiding_remaining = combat_settings.hiding_seconds
	_apply_controls()


func _feedback(message: String) -> void:
	$HUD/Feedback.text = message
	feedback_remaining = 2.0


func _notification(what: int) -> void:
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT and is_node_ready():
		_set_active(false)


func _resume() -> void:
	_set_active(true)


func _reset() -> void:
	finished = false
	survivor_lives = combat_settings.starting_lives
	player_weapon.settings = combat_settings
	bot_weapon.settings = combat_settings
	player_weapon.reset_weapon()
	bot_weapon.reset_weapon()
	feedback_remaining = 0.0
	$HUD/Feedback.text = ""
	_begin_hiding()
	_set_active(true)


func _apply_controls() -> void:
	var hiding := hiding_remaining > 0.0
	player.set_controls_active(training_running and (not hiding or player.role == &"survivor"))
	bot.set_active(training_running and (not hiding or bot.role == &"survivor") and not bot_weapon.attacking)
	bot.visible = has_selected_role and not (hiding and player.role == &"hunter")


func _update_hud() -> void:
	$HUD/Lives.visible = has_selected_role
	$HUD/CombatStatus.visible = has_selected_role
	var owner_label := "Vos vies" if player.role == &"survivor" else "Vies du survivant IA"
	$HUD/Lives.text = "%s : %d / %d" % [owner_label, survivor_lives, combat_settings.starting_lives]
	if finished:
		$HUD/CombatStatus.text = "Fin de l'entraînement"
	elif hiding_remaining > 0.0:
		var instruction := "Cachez-vous" if player.role == &"survivor" else "Le survivant se cache"
		$HUD/CombatStatus.text = "%s · %d s" % [instruction, ceili(hiding_remaining)]
	elif player.role == &"hunter":
		$HUD/CombatStatus.text = "Branche · clic gauche pour frapper" if player_weapon.cooldown_remaining <= 0.0 else "Branche · recharge %.1f s" % player_weapon.cooldown_remaining
	else:
		$HUD/CombatStatus.text = "Évitez la branche du chasseur"


func _set_active(active: bool) -> void:
	training_running = active and has_selected_role and not finished
	_apply_controls()
	overlay.visible = not training_running
	crosshair.visible = training_running
	resume_button.visible = has_selected_role and not finished
	reset_button.visible = has_selected_role
	if finished:
		heading.text = "Victoire du chasseur !" if player.role == &"hunter" else "Vous avez été attrapé !"
	else:
		heading.text = "Entraînement en pause" if has_selected_role else "Choisissez votre rôle"
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if training_running else Input.MOUSE_MODE_VISIBLE
	_update_hud()
	if not training_running:
		if finished:
			reset_button.grab_focus()
		elif has_selected_role:
			resume_button.grab_focus()
		elif not survivor_button.disabled:
			survivor_button.grab_focus()


func _exit_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
