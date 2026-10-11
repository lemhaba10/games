extends Node3D

@onready var player: CharacterBody3D = $Player
@onready var overlay: Control = $HUD/Overlay
@onready var crosshair: Control = $HUD/Crosshair
@onready var resume_button: Button = $HUD/Overlay/Center/Card/Margin/Content/Resume
@onready var reset_button: Button = $HUD/Overlay/Center/Card/Margin/Content/Reset


func _ready() -> void:
	resume_button.pressed.connect(_resume)
	reset_button.pressed.connect(_reset)
	_set_active(false)
	resume_button.grab_focus()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
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
	_set_active(true)


func _set_active(active: bool) -> void:
	player.set_controls_active(active)
	overlay.visible = not active
	crosshair.visible = active
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if active else Input.MOUSE_MODE_VISIBLE
	if not active:
		resume_button.grab_focus()


func _exit_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
