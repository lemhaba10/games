class_name CombatSettings
extends Resource

@export_group("Survivant")
@export_range(1, 10, 1) var starting_lives: int = 3
@export_range(0.0, 60.0, 0.5, "suffix:s") var hiding_seconds: float = 30.0

@export_group("Branche")
@export_range(0.5, 5.0, 0.1, "suffix:m") var branch_range: float = 1.8
@export_range(5.0, 60.0, 1.0, "degrees") var branch_half_angle: float = 35.0
@export_range(0.05, 2.0, 0.05, "suffix:s") var branch_windup: float = 0.25
@export_range(0.1, 10.0, 0.1, "suffix:s") var branch_cooldown: float = 1.0
