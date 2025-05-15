extends Node3D

@export_category("A* Search")
@export var grid_map_cell_size: int = 1
@export var grid_walkable_items: Array[int] = [0] # what is the id of the walkable tile type in GridMap
@export var start_tile: Vector3i = Vector3i(-2,0,24)
@export var end_tile: Vector3i = Vector3i(4,0,0)
@export var test_tile: Vector3i = Vector3i(-2,0,18)
@onready var grid_map: GridMap = $GridMap

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GridMapPathFinding.setup_astar_grid(grid_map, grid_walkable_items, grid_map_cell_size)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	GridMapPathFinding.do_debug_path(grid_map, grid_map_cell_size, start_tile, end_tile)

func _on_remove_tile_toggled(toggled_on: bool) -> void:
	if toggled_on:
		grid_map.set_cell_item(test_tile, grid_walkable_items[0], 0) # stone floor tile, walkable
	else:
		grid_map.set_cell_item(test_tile, 2, 0) # 2 is a wall
	GridMapPathFinding.setup_astar_grid(grid_map, grid_walkable_items, grid_map_cell_size)

func _on_add_wood_toggled(toggled_on: bool) -> void:
	if toggled_on:
		grid_walkable_items = [0,1] # stone and wood floor tile
	else:
		grid_walkable_items = [0] # just stone floor tile
	GridMapPathFinding.setup_astar_grid(grid_map, grid_walkable_items, grid_map_cell_size)

func _input(event: InputEvent) -> void:
	if event.is_action("ui_cancel"):
		get_tree().quit()
