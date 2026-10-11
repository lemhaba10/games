class_name PlayerSettings
extends Resource
## Réglages du premier personnage, modifiables dans l'inspecteur Godot.

@export_group("Déplacement")
@export_range(0.5, 15.0, 0.1, "suffix:m/s") var run_speed: float = 5.0
@export_range(0.5, 15.0, 0.1, "suffix:m/s") var hunter_run_speed: float = 5.2
@export_range(0.5, 10.0, 0.1, "suffix:m/s") var walk_speed: float = 2.5
@export_range(1.0, 60.0, 0.5, "suffix:m/s²") var acceleration: float = 24.0
@export_range(1.0, 40.0, 0.5, "suffix:m/s²") var gravity: float = 20.0

@export_group("Vue")
@export_range(0.0005, 0.01, 0.0001) var mouse_sensitivity: float = 0.002
@export_range(50.0, 110.0, 1.0, "degrees") var field_of_view: float = 80.0
@export_range(45.0, 89.0, 1.0, "degrees") var pitch_limit: float = 85.0
