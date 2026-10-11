extends CharacterBody3D

@export var movement_settings: PlayerSettings
@export var ai_settings: AISettings

@onready var model: Node3D = $Model
@onready var torso: MeshInstance3D = $Model/Torso
@onready var name_label: Label3D = $Name

var navigation: PracticeNavigation
var role: StringName = &"hunter"
var active: bool = false
var spawn_transform: Transform3D
var route := PackedVector3Array()
var waypoint: int = 0
var pause_remaining: float = 0.0
var stuck_time: float = 0.0
var animation_time: float = 0.0
var destinations_chosen: int = 0
var rng := RandomNumberGenerator.new()


func _ready() -> void:
	spawn_transform = global_transform
	rng.randomize()
	set_role(role)


func set_role(new_role: StringName) -> void:
	role = new_role
	var material := StandardMaterial3D.new()
	material.albedo_color = Color("e3694f") if role == &"hunter" else Color("36cdb3")
	material.roughness = 0.8
	torso.material_override = material
	name_label.text = "IA · Chasseur" if role == &"hunter" else "IA · Survivant"


func movement_speed() -> float:
	var speed := movement_settings.hunter_run_speed if role == &"hunter" else movement_settings.run_speed
	return speed * ai_settings.speed_multiplier


func set_active(value: bool) -> void:
	active = value
	if not active:
		velocity = Vector3.ZERO


func reset_to_spawn() -> void:
	global_transform = spawn_transform
	velocity = Vector3.ZERO
	route.clear()
	waypoint = 0
	pause_remaining = 0.0
	stuck_time = 0.0
	animation_time = 0.0
	_animate(0.0)


func _physics_process(delta: float) -> void:
	if not active or navigation == null or not navigation.ready_for_paths:
		return
	var horizontal := Vector3.ZERO
	if pause_remaining > 0.0:
		pause_remaining -= delta
	else:
		if waypoint >= route.size():
			route = navigation.random_path(global_position, rng, ai_settings.minimum_trip_distance)
			waypoint = 0
			if not route.is_empty():
				destinations_chosen += 1
			else:
				pause_remaining = 0.5
		if waypoint < route.size():
			var offset := route[waypoint] - global_position
			offset.y = 0.0
			if offset.length() < 0.08:
				waypoint += 1
				if waypoint >= route.size():
					pause_remaining = ai_settings.destination_pause
			else:
				horizontal = offset.normalized() * minf(movement_speed(), offset.length() / delta)
	velocity.x = horizontal.x
	velocity.z = horizontal.z
	if not is_on_floor():
		velocity.y -= movement_settings.gravity * delta
	else:
		velocity.y = 0.0
	var previous := global_position
	move_and_slide()
	var travelled := Vector2(global_position.x - previous.x, global_position.z - previous.z).length()
	if horizontal.length() > 0.1 and travelled < 0.01:
		stuck_time += delta
		if stuck_time >= ai_settings.stuck_timeout:
			route.clear()
			stuck_time = 0.0
	else:
		stuck_time = 0.0
	if travelled > 0.001:
		model.rotation.y = lerp_angle(model.rotation.y, atan2(-horizontal.x, -horizontal.z), minf(delta * 10.0, 1.0))
		animation_time += travelled * 2.5
	_animate(minf(travelled / delta, 1.0))
	if global_position.y < -10.0:
		reset_to_spawn()


func _animate(weight: float) -> void:
	var swing := sin(animation_time) * 0.45 * weight
	$Model/LeftLeg.rotation.x = swing
	$Model/RightLeg.rotation.x = -swing
	$Model/LeftArm.rotation.x = -swing
	$Model/RightArm.rotation.x = swing
