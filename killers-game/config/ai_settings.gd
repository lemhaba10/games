class_name AISettings
extends Resource

@export_range(0.1, 2.0, 0.05) var speed_multiplier: float = 1.0
@export_range(0.0, 5.0, 0.1, "suffix:s") var destination_pause: float = 0.4
@export_range(1.0, 15.0, 0.5, "suffix:m") var minimum_trip_distance: float = 4.0
@export_range(0.5, 5.0, 0.1, "suffix:s") var stuck_timeout: float = 1.5
