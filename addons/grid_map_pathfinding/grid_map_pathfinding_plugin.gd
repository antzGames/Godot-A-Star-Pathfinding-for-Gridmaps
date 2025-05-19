@tool
extends EditorPlugin

var gme: GridMapEditorPlugin
var has_selection: bool = false
var last_single_cell_selected: Vector3i
var dock

func _ready() -> void:
	ResourceSaver.save(preload("res://addons/grid_map_pathfinding/grid_map_pathfinding.gd"))

func _enter_tree() -> void:
	# New custom node
	add_custom_type("GridMapPathFinding", "GridMap", preload("res://addons/grid_map_pathfinding/grid_map_pathfinding.gd"), preload("res://addons/grid_map_pathfinding/GridMap.svg"))

	# Dock
	var root = get_editor_interface().get_resource_filesystem().get_node("/root")
	gme = root.find_children("", "GridMapEditorPlugin", true, false)[0]
	dock = preload("res://addons/grid_map_pathfinding/GridMapPathFindingDock.tscn").instantiate()
	add_control_to_dock(DOCK_SLOT_RIGHT_BL, dock) # below inspector dock
	dock.find_child("AddStart").pressed.connect(do_start_cell_button)
	dock.find_child("AddEnd").pressed.connect(do_end_cell_button)
	dock.find_child("AddItemID").pressed.connect(do_add_item_id)

func _exit_tree():
	# Remove the dock.
	remove_control_from_docks(dock)
	# Erase the control from the memory.
	dock.free()
	# Remove custom node
	remove_custom_type("GridMapPathFinding")

func _process(delta):
	if Engine.is_editor_hint():
		if gme:
			# detect single selections only
			if gme.has_selection() and gme.get_selected_cells().size() == 1:
				dock.find_child("Title").text = "Selected Cell"
				if has_selection and gme.get_selected_cells()[0] == last_single_cell_selected:
					if dock:
						update_labels()
				else:
					has_selection = true
					last_single_cell_selected = gme.get_selected_cells()[0]
					if dock:
						dock.find_child("CellPos").text = str(Vector3(last_single_cell_selected))
						dock.find_child("LocalPos").text = str(gme.get_current_grid_map().map_to_local(gme.get_selected_cells()[0]))
						dock.find_child("ItemName").text = gme.get_current_grid_map().mesh_library.get_item_name(gme.get_current_grid_map().get_cell_item(gme.get_selected_cells()[0]))
						dock.find_child("ItemID").text = str(gme.get_current_grid_map().get_cell_item(gme.get_selected_cells()[0]))
						dock.find_child("MeshPreview").texture = gme.get_current_grid_map().mesh_library.get_item_preview(gme.get_current_grid_map().get_cell_item(gme.get_selected_cells()[0]))
						
						dock.find_child("CellPos").visible = true
						dock.find_child("LocalPos").visible = true
						dock.find_child("ItemName").visible = true
						dock.find_child("ItemID").visible = true
						dock.find_child("MeshPreview").visible = true
						dock.find_child("AddStart").visible = true
						dock.find_child("AddStart").visible = true
						dock.find_child("AddEnd").visible = true
						update_labels()
			else:
				has_selection = false
				dock.find_child("CellPos").visible = false
				dock.find_child("LocalPos").visible = false
				dock.find_child("ItemName").visible = false
				dock.find_child("ItemID").visible = false
				dock.find_child("AddItemID").visible = false
				dock.find_child("Info").visible = false
				dock.find_child("MeshPreview").visible = false
				dock.find_child("AddStart").visible = false
				dock.find_child("AddStart").visible = false
				dock.find_child("AddEnd").visible = false
				dock.find_child("Title").text = "No Cell Selected"
				
			if gme.get_current_grid_map():
				gme.get_current_grid_map().do_debug_path(gme.get_current_grid_map().debug_start_cell, gme.get_current_grid_map().debug_end_cell)

func update_labels():
	if gme.get_current_grid_map().walkable_items.has(gme.get_current_grid_map().get_cell_item(gme.get_selected_cells()[0])):
		dock.find_child("Info").add_theme_color_override("font_color", Color.GREEN)
		dock.find_child("Info").text = "This Item ID is in Walkable Items"
		dock.find_child("Info").visible = true
		dock.find_child("AddItemID").visible = false
	else:
		dock.find_child("AddItemID").visible = true
		dock.find_child("Info").add_theme_color_override("font_color", Color.RED)
		dock.find_child("Info").text = "This Item ID is NOT in Walkable Items"
		dock.find_child("Info").visible = true

func do_start_cell_button():
	if has_selection:
		gme.get_current_grid_map().debug_start_cell = last_single_cell_selected
		gme.get_current_grid_map().setup_astar_grid(gme.get_current_grid_map().walkable_items)
		
func do_end_cell_button():
	if has_selection:
		gme.get_current_grid_map().debug_end_cell = last_single_cell_selected
		gme.get_current_grid_map().setup_astar_grid(gme.get_current_grid_map().walkable_items)

func do_add_item_id():
	var new_array: Array[int]
	new_array = gme.get_current_grid_map().walkable_items.duplicate()
	new_array.append(gme.get_current_grid_map().get_cell_item(gme.get_selected_cells()[0]))
	gme.get_current_grid_map().set_walkable_items(new_array)
