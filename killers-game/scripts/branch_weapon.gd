class_name BranchWeapon
extends Node3D
## L'arène pilote le temps : le menu suspend aussi l'attaque et sa recharge.

signal impact

var settings: CombatSettings
var cooldown_remaining: float = 0.0
var windup_remaining: float = 0.0
var attacking: bool = false
var rest_rotation: Vector3


func _ready() -> void:
	rest_rotation = rotation


func try_attack() -> bool:
	if attacking or cooldown_remaining > 0.0 or settings == null:
		return false
	attacking = true
	windup_remaining = settings.branch_windup
	cooldown_remaining = settings.branch_cooldown
	return true


func tick(delta: float) -> void:
	cooldown_remaining = maxf(0.0, cooldown_remaining - delta)
	if attacking:
		windup_remaining = maxf(0.0, windup_remaining - delta)
		var progress := 1.0 - windup_remaining / settings.branch_windup
		rotation = rest_rotation + Vector3(-sin(progress * PI) * 1.3, 0, -sin(progress * PI) * 0.6)
		if windup_remaining <= 0.0:
			attacking = false
			rotation = rest_rotation
			impact.emit()


func reset_weapon() -> void:
	cooldown_remaining = 0.0
	cancel_swing()


func cancel_swing() -> void:
	windup_remaining = 0.0
	attacking = false
	rotation = rest_rotation
