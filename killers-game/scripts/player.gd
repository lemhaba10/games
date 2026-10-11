extends CharacterBody3D

@export var settings: PlayerSettings

@onready var camera: Camera3D = $Camera3D

var controls_active: bool = false
var spawn_transform: Transform3D


func _ready() -> void:
	spawn_transform = global_transform
	camera.fov = settings.field_of_view


func _unhandled_input(event: InputEvent) -> void:
	if not controls_active:
		return
	if event is InputEventMouseMotion:
		rotate_y(-event.screen_relative.x * settings.mouse_sensitivity)
		camera.rotation.x = clampf(
			camera.rotation.x - event.screen_relative.y * settings.mouse_sensitivity,
			-deg_to_rad(settings.pitch_limit),
			deg_to_rad(settings.pitch_limit)
		)


func _physics_process(delta: float) -> void:
	var direction := Vector3.ZERO
	var speed := settings.run_speed
	if controls_active:
		var movement := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
		direction = global_basis * Vector3(movement.x, 0.0, movement.y)
		if Input.is_action_pressed("walk"):
			speed = settings.walk_speed
	velocity.x = move_toward(velocity.x, direction.x * speed, settings.acceleration * delta)
	velocity.z = move_toward(velocity.z, direction.z * speed, settings.acceleration * delta)
	if not is_on_floor():
		velocity.y -= settings.gravity * delta
	else:
		velocity.y = 0.0
	move_and_slide()
	# Secours si la carte est modifiée et que le personnage tombe dans le vide.
	if global_position.y < -10.0:
		reset_to_spawn()


func set_controls_active(active: bool) -> void:
	controls_active = active
	if not active:
		velocity.x = 0.0
		velocity.z = 0.0


func reset_to_spawn() -> void:
	global_transform = spawn_transform
	velocity = Vector3.ZERO
	camera.rotation = Vector3.ZERO
