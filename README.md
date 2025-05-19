## Godot A* Pathfinding for Gridmaps Plugin

<img src="https://github.com/user-attachments/assets/698771ce-eaa8-47ee-b058-78808bdd1a59" width="580" height="270">

An extended version of Godot's `GridMap` node that adds A* pathfinding support and in editor visual pathfinding debugging.

Now implemented as a plugin.

This solution is great for 3D Dungeon Crawler games where you need to do pathfinding in discrete amounts in a grid pattern.

## Limitations

All GridMap tile sizes in its MeshLibrary have to be the same size.

## How to install as a plugin

Add `grid_map_pathfinding` folder to your `addons` directory as shown below:

<img src="https://github.com/user-attachments/assets/1a947054-8eea-46b6-9985-6f3170a0c0a3" width="182" height="181">

## Using the new `GridMapPathFinding` node

<img src="https://github.com/user-attachments/assets/49a4f814-c12c-4a75-8be5-d0e9168470f0" width="407" height="247">

## Plugin's inspector changes

### Path Cell Size

Not to be confused with `GridMap.cell_size`.  So because the mesh cell size of KayKit and Kenney 3D tile asset packs may differ, and even
within asset packs they may have different mesh sizes (like small, medium, large versions of tiles) you have to be very careful in 
setting the GridMap `cell_size` and this plugin's `path_cell_size`.

Finding out the correct `path_cell_size` and GridMap `cell_size` might take some investigation.  But once figured out you do not have to worry about it again.

The best advice I can give you is that when drawing cells in your GridMap, make sure when you draw the tiles, they do not overlap.  This will result in you skipping a grid tile.  This means you will need to adjust the `path_cell_size` to value higher than 1, and probably 2.

 The reason behind this is beyond the scope of this plugin's documentation.  

Also, as previously documented in the Limitations section, all your tiles have to be the same size.

<img src="https://github.com/user-attachments/assets/f0e5eac8-e7bf-44b5-9280-df13faa6b7b5" width="172.5" height="222.5">

## Custom dock

### Scenario 1: Selected cell **NOT** in the `walkable_items` array
When the selected cell in the grid map is **NOT** in the `walkable_items` array, which is going to be the case in a new project, you will see this in the dock:

<img src="https://github.com/user-attachments/assets/9fe8d90c-8c7c-4bbf-9b83-57fcb42e4793" width="175" height="218.5">

You can click `Add Item ID to Walkable Items` button to add thsi item id (tile type) to the `walkable_items` array.

You can click `Add to Start Cell` button to assign the debug start cell to this grid position.
You can click `Add to End Cell` button to assign the debug end cell to this grid position.

### Scenario 2: Selected cell already in the `walkable_items` array

When the selected cell in the grid map is in the `walkable_items` array, you will see this:

<img src="https://github.com/user-attachments/assets/9bf1be71-7188-40f1-afae-2ff6da5dea19" width="175" height="218.5">

You can click `Add to Start Cell` button to assign the debug start cell to this grid position.
You can click `Add to End Cell` button to assign the debug end cell to this grid position.

### Scenario 3: Selected cell not assigned a tile

When the selected cell does not have any assigned tile, then you will see this:

<img src="https://github.com/user-attachments/assets/ad212ab6-8c02-45be-b08c-890fd9a33ad1" width="175" height="218.5">

## Optional in editor pathfinding debug

<img src="https://github.com/user-attachments/assets/178e1b13-6d5f-4aae-89d3-c5fc1e794f22" width="225" height="55">

## GridMap location to world space and vice versa

One of the things I should have discussed in the tutorial video is that GridMap co-ordinate system is not the same as the world space.

You need to convert GridMap locations to world space with:

`grid_map.map_to_local(map_position: Vector3i) -> Vector3`

to convert world locations to GridMap locations with:

`grid_map.local_to_map(local_position: Vector3) -> Vector3i`

See https://docs.godotengine.org/en/stable/classes/class_gridmap.html for more information.

## Game Jam Example

 I used this solution in my Dungeon Crawler Game Jam 2025 entry: https://antzgames.itch.io/dungeon-heist

<img src="https://github.com/user-attachments/assets/36c83fca-f273-4075-83b7-1864502daaf2" idth="315" height="250">

