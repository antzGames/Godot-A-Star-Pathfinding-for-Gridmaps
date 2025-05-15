extends Node

# A*
var astar = AStar3D.new()
var point_id_map = {}
var points: PackedVector3Array

func setup_astar_grid(grid_map_in: GridMap, grid_walkable_items: Array[int], grid_map_cell_size: int):
	# Clear previous A* data
	astar.clear()
	point_id_map.clear()
	
	# For all walkable tiles in grid
	for item_id: int in grid_walkable_items:
		# Iterate through the grid to find walkable cells
		for cell_pos: Vector3i in grid_map_in.get_used_cells_by_item(item_id):
			var point_id = astar.get_available_point_id()
			astar.add_point(point_id, cell_pos)
			point_id_map[cell_pos] = point_id
			#print(cell_pos) 
	
	# Connect neighboring points
	for point_id in astar.get_point_ids():
		var point_pos = astar.get_point_position(point_id)
		var neighbors = [
			Vector3(point_pos.x + grid_map_cell_size, point_pos.y, point_pos.z),
			Vector3(point_pos.x - grid_map_cell_size, point_pos.y, point_pos.z),
			Vector3(point_pos.x, point_pos.y, point_pos.z + grid_map_cell_size),
			Vector3(point_pos.x, point_pos.y, point_pos.z - grid_map_cell_size)
		]
		
		for neighbor_pos in neighbors:
			var neighbor_cell = Vector3i(neighbor_pos.x, neighbor_pos.y, neighbor_pos.z)
			if point_id_map.has(neighbor_cell):
				var neighbor_id = point_id_map[neighbor_cell]
				if not astar.are_points_connected(point_id, neighbor_id):
					astar.connect_points(point_id, neighbor_id)

func find_path(start: Vector3i, end: Vector3i) -> Array:
	# Ensure start and end are within the grid and walkable
	if not point_id_map.has(start) or not point_id_map.has(end):
		return [] # No valid path
	
	var start_id = point_id_map[start]
	var end_id = point_id_map[end]
	
	# Get the path as an array of Vector3 points
	var path = astar.get_point_path(start_id, end_id)
	return path

# This method needs the Debug Draw 3D plugin from the AssetLib
func do_debug_path(grid_map_in: GridMap, grid_map_cell_size: int, start_pos, target_pos):
	var path = find_path(start_pos, target_pos)
	DebugDraw2D.set_text("1. Grid count: ", astar.get_point_count())
	DebugDraw2D.set_text("2. Path length: ", path.size())  # if you get -1 then no path found
	DebugDraw2D.set_text("3. Start Grid Location / Start World Location: ", str(start_pos, " / ", grid_map_in.map_to_local(start_pos)))
	DebugDraw2D.set_text("4. End Grid Location / End World Location: ", str(target_pos, " / ", grid_map_in.map_to_local(target_pos)))
	var i: int = 0
	points.resize(path.size())
	
	for next_point: Vector3 in path:
		points[i] = grid_map_in.map_to_local(next_point)
		points[i].y += grid_map_cell_size # move debug the box up
		if i == 0: 
			DebugDraw3D.draw_box(points[i],Quaternion.IDENTITY,Vector3(grid_map_cell_size,grid_map_cell_size,grid_map_cell_size), Color.GREEN, true)
		elif i == path.size() - 1: 
			DebugDraw3D.draw_box(points[i],Quaternion.IDENTITY,Vector3(grid_map_cell_size,grid_map_cell_size,grid_map_cell_size), Color.RED, true)
		else:
			DebugDraw3D.draw_box(points[i],Quaternion.IDENTITY,Vector3(grid_map_cell_size,grid_map_cell_size,grid_map_cell_size), Color.YELLOW, true)
		i += 1

	DebugDraw3D.draw_point_path(points)
