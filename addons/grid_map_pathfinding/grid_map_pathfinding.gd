@tool
extends GridMap
class_name GridMapPathFinding
## Adds a simple A* pathfinding solution to [GridMap].
##
## Assign which item types in your [GridMap] are walkable.[br]
## Allows debugging of A* pathfinding in the editor.[br]
## Adds a custom dock for more information on selected grid tile.[br][br]
## Adds the following methods:[br][br]
## [method GridMapPathFinding.setup_astar_grid][br]
## [method GridMapPathFinding.find_path][br]
## [method GridMapPathFinding.do_debug_path][br]

## The [AStar3D] instance that can be used in your games.
var astar: AStar3D = AStar3D.new()
## This array holds all point_ids that are walkable.
var point_id_map = {}
## A reuseable variable for loops.  Can ignore.
var points: PackedVector3Array

## The distance between A* path points in [GridMap] co-ordinates.[br][br]
## See online documentation to help with confusion with [method GridMap.cell_size].
@export var path_cell_size: int = 1
## The [GridMap]'s [MeshLibrary] item ids assigned as walkable items.[br]
## Walkable items tell A* pathfinding which cells participate in pathfinding.[br][br]
## Use the [b]GridMapPathFindingDock[/b] to visually add item ids to this array.[br][br]
## You need at least one walkable item id for A* pathfinding to work.
@export var walkable_items: Array[int] = []:
	set = set_walkable_items # what is the id of the walkable tile type in GridMap

@export_category("In Editor Debug")
## The start path [GridMap] position for in editor debugging.[br][br]
## This is only used in the editor to debug pathfinding.
@export var debug_start_cell: Vector3i
## The end path [GridMap] position for in editor debugging.[br][br]
## This is only used in the editor to debug pathfinding.
@export var debug_end_cell: Vector3i
## Enable/disable in editor debugging.[br][br]
## This is only used in the editor to debug pathfinding.
@export var show_debug: bool = true

## Setter method for walkable_items
func set_walkable_items(_in_array :Array[int]):
	walkable_items = _in_array
	setup_astar_grid(walkable_items)	

func _ready() -> void:
	if Engine.is_editor_hint():
		setup_astar_grid(walkable_items)

## Initialize A* pathfinding with the currently selected walkable item ids.[br][br]
## You should only call this once or if the gird map has changed.
func setup_astar_grid(grid_walkable_items: Array[int]):
	# Clear previous A* data
	astar.clear()
	point_id_map.clear()
	
	# For all walkable tiles in grid map
	for item_id: int in grid_walkable_items:
		# Iterate through the grid to find walkable cells
		for cell_pos: Vector3i in get_used_cells_by_item(item_id):
			var point_id: int = astar.get_available_point_id()
			astar.add_point(point_id, cell_pos)
			point_id_map[cell_pos] = point_id
			#print(cell_pos) 
	
	# Connect neighboring points
	for point_id in astar.get_point_ids():
		var point_pos: Vector3 = astar.get_point_position(point_id)
		var neighbors = [
			Vector3(point_pos.x + path_cell_size, point_pos.y, point_pos.z),
			Vector3(point_pos.x - path_cell_size, point_pos.y, point_pos.z),
			Vector3(point_pos.x, point_pos.y, point_pos.z + path_cell_size),
			Vector3(point_pos.x, point_pos.y, point_pos.z - path_cell_size)
		]
		
		# Only connect neighnors that are navigable, and only connect them once
		for neighbor_pos in neighbors:
			var neighbor_cell: Vector3i = Vector3i(neighbor_pos.x, neighbor_pos.y, neighbor_pos.z)
			if point_id_map.has(neighbor_cell):
				var neighbor_id: int = point_id_map[neighbor_cell]
				if not astar.are_points_connected(point_id, neighbor_id):
					astar.connect_points(point_id, neighbor_id)

## Call when you need to find the path between two actor positions.[br][br]
## Both start and end positions must be walkable cells in the [GridMap].[br][br]
## Note: the actor postions have to be on the same y-position as the grid map tiles
func find_path(start: Vector3i, end: Vector3i) -> Array:
	# Ensure start and end are within the grid and walkable
	if not point_id_map.has(start) or not point_id_map.has(end):
		return [] # No valid path
	
	var start_id: int = point_id_map[start]
	var end_id: int = point_id_map[end]
	
	# Get the path as an array of Vector3 points
	var path = astar.get_point_path(start_id, end_id)
	return path

## Draws graphical debug path between start and end positions.[br][br]
## Both start and end positions must be walkable cells in the [GridMap].[br][br]
## Start position is a green box, and end position is a red box.
func do_debug_path(start_pos, end_pos):
	if !show_debug: return

	var path = find_path(start_pos, end_pos)
	if astar.get_point_count() == 0: return
	
	DebugDraw2D.set_text("1. Grid count: ", astar.get_point_count())
	DebugDraw2D.set_text("2. Walkable Ids: ", walkable_items)
	if path.size() < 1:
		DebugDraw2D.set_text("3. Path length: ", "No path found")
	else:
		DebugDraw2D.set_text("3. Path length: ", path.size())
	DebugDraw2D.set_text("4. Start Grid Location / Start World Location: ", str(start_pos, " / ", map_to_local(start_pos)), 0, Color.GREEN)
	DebugDraw2D.set_text("5. End Grid Location / End World Location: ", str(end_pos, " / ", map_to_local(end_pos)), 0, Color.RED)
	
	var i: int = 0
	points.resize(path.size())
	
	var temp: Vector3 = map_to_local(start_pos)
	temp.y += path_cell_size
	DebugDraw3D.draw_box(temp, Quaternion.IDENTITY, Vector3(path_cell_size, path_cell_size, path_cell_size), Color.GREEN, true)
	temp = map_to_local(end_pos)
	temp.y += path_cell_size
	DebugDraw3D.draw_box(temp, Quaternion.IDENTITY, Vector3(path_cell_size, path_cell_size, path_cell_size), Color.RED, true)
	
	# Draw boxes: Green = start, Red = end, Yellow = all others
	for next_point: Vector3 in path:
		points[i] = map_to_local(next_point)
		points[i].y += path_cell_size # move debug the box up
		if i > 0 and i < path.size() - 1: 
			DebugDraw3D.draw_box(points[i], Quaternion.IDENTITY, Vector3(path_cell_size, path_cell_size, path_cell_size), Color.YELLOW, true)
		i += 1

	# draw point path for added effect
	DebugDraw3D.draw_point_path(points)
	
