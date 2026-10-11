extends Node3D

@onready var player: CharacterBody3D = $Player
@onready var bot: CharacterBody3D = $Bot
@onready var navigation: PracticeNavigation = $Navigation
@onready var overlay: Control = $HUD/Overlay
@onready var crosshair: Control = $HUD/Crosshair
@onready var resume_button: Button = $HUD/Overlay/Center/Card/Margin/Content/Resume
@onready var reset_button: Button = $HUD/Overlay/Center/Card/Margin/Content/Reset
@onready var survivor_button: Button = $HUD/Overlay/Center/Card/Margin/Content/Roles/Survivor
@onready var hunter_button: Button = $HUD/Overlay/Center/Card/Margin/Content/Roles/Hunter
@onready var heading: Label = $HUD/Overlay/Center/Card/Margin/Content/Heading

var has_selected_role: bool = false


func _ready() -> void:
	resume_button.pressed.connect(_resume)
	reset_button.pressed.connect(_reset)
	survivor_button.pressed.connect(start_training.bind(&"survivor"))
	hunter_button.pressed.connect(start_training.bind(&"hunter"))
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
	bot.visible = true
	$HUD/PlayerName.text = "Vous : Survivant  ·  IA : Chasseur" if role == &"survivor" else "Vous : Chasseur  ·  IA : Survivant"
	_reset()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if has_selected_role:
			_set_active(not player.controls_active)
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("reset_position") and player.controls_active:
		player.reset_to_spawn()
		get_viewport().set_input_as_handled()


func _notification(what: int) -> void:
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT and is_node_ready():
		_set_active(false)


func _resume() -> void:
	_set_active(true)


func _reset() -> void:
	player.reset_to_spawn()
	bot.reset_to_spawn()
	_set_active(true)


func _set_active(active: bool) -> void:
	active = active and has_selected_role
	player.set_controls_active(active)
	bot.set_active(active)
	overlay.visible = not active
	crosshair.visible = active
	resume_button.visible = has_selected_role
	reset_button.visible = has_selected_role
	heading.text = "Entraînement en pause" if has_selected_role else "Choisissez votre rôle"
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if active else Input.MOUSE_MODE_VISIBLE
	if not active:
		if has_selected_role:
			resume_button.grab_focus()
		elif not survivor_button.disabled:
			survivor_button.grab_focus()


func _exit_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
