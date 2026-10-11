class_name PracticeNavigation
extends Node3D
## Grille au sol de cette arène plane, calculée depuis ses collisions statiques.

@export var grid_region := Rect2i(-14, -14, 29, 29)
@export_range(0.5, 2.0, 0.1) var cell_size: float = 1.0
@export_range(0.35, 0.8, 0.05) var clearance_radius: float = 0.55

var grid := AStarGrid2D.new()
var free_cells: Array[Vector2i] = []
var ready_for_paths: bool = false


func build() -> void:
	grid.region = grid_region
	grid.cell_size = Vector2.ONE * cell_size
	grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	grid.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	grid.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	grid.update()
	free_cells.clear()
	var capsule := CapsuleShape3D.new()
	capsule.radius = clearance_radius
	capsule.height = 1.8
	var query := PhysicsShapeQueryParameters3D.new()
	query.shape = capsule
	query.collision_mask = 1 # Décor uniquement ; les personnages occupent la couche 2.
	var space := get_world_3d().direct_space_state
	for x in range(grid_region.position.x, grid_region.end.x):
		for z in range(grid_region.position.y, grid_region.end.y):
			var cell := Vector2i(x, z)
			query.transform = Transform3D(Basis.IDENTITY, Vector3(x * cell_size, 1.0, z * cell_size))
			var blocked := not space.intersect_shape(query, 1).is_empty()
			grid.set_point_solid(cell, blocked)
			if not blocked:
				free_cells.append(cell)
	ready_for_paths = not free_cells.is_empty()


func nearest_cell(point: Vector3) -> Vector2i:
	var nearest := Vector2i.ZERO
	var best_distance := INF
	for cell in free_cells:
		var distance := Vector2(point.x, point.z).distance_squared_to(Vector2(cell) * cell_size)
		if distance < best_distance:
			nearest = cell
			best_distance = distance
	return nearest


func path_between(from: Vector3, to: Vector3) -> PackedVector3Array:
	var path := PackedVector3Array()
	if not ready_for_paths:
		return path
	for point in grid.get_point_path(nearest_cell(from), nearest_cell(to)):
		path.append(Vector3(point.x, 0.0, point.y))
	return path


func random_path(from: Vector3, rng: RandomNumberGenerator, minimum_distance: float) -> PackedVector3Array:
	if not ready_for_paths:
		return PackedVector3Array()
	for attempt in 24:
		var destination := Vector2(free_cells[rng.randi_range(0, free_cells.size() - 1)]) * cell_size
		if destination.distance_to(Vector2(from.x, from.z)) < minimum_distance:
			continue
		var path := path_between(from, Vector3(destination.x, 0.0, destination.y))
		if path.size() > 1:
			return path
	return PackedVector3Array()
