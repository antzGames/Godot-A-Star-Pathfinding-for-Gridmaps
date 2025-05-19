## Godot A* Pathfinding for Gridmaps Plugin

<img src="https://github.com/user-attachments/assets/698771ce-eaa8-47ee-b058-78808bdd1a59">

An extended version of Godot's GridMap node that adds A* Pathfinding and in editor debugging.

Now implemented as a plugin.

This solution is great for 3D Dungeon Crawler games where you need to do pathfinding in discrete amounts in a grid pattern.

## How to install as a plugin

Add `grid_map_pathfinding` folder to your `addons` directory as shown below:

![plugin](https://github.com/user-attachments/assets/1a947054-8eea-46b6-9985-6f3170a0c0a3)

## Using the new `GridMapPathFinding` node

![new_node](https://github.com/user-attachments/assets/49a4f814-c12c-4a75-8be5-d0e9168470f0)

## Plugin's inspector changes

![New_inspect](https://github.com/user-attachments/assets/f0e5eac8-e7bf-44b5-9280-df13faa6b7b5)

## Custom dock

### Scenario 1: Selected cell **NOT** in the `walkable_items` array
When the selected cell in the grid map is **NOT** in the `walkable_items` array, which is going to be the case in a new project, you will see this in the dock:

![not_in](https://github.com/user-attachments/assets/9fe8d90c-8c7c-4bbf-9b83-57fcb42e4793)

You can click `Add Item ID to Walkable Items` button to add thsi item id (tile type) to the `walkable_items` array.

You can click `Add to Start Cell` button to assign the debug start cell to this grid position.
You can click `Add to End Cell` button to assign the debug end cell to this grid position.

### Scenario 2: Selected cell already in the `walkable_items` array

When the selected cell in the grid map is in the `walkable_items` array, you will see this:

![is_in](https://github.com/user-attachments/assets/9bf1be71-7188-40f1-afae-2ff6da5dea19)

You can click `Add to Start Cell` button to assign the debug start cell to this grid position.
You can click `Add to End Cell` button to assign the debug end cell to this grid position.

### Scenario 3: Selected cell not assigned a tile

When the selected cell does not have any assigned tile, then you will see this:

![no_selected](https://github.com/user-attachments/assets/ad212ab6-8c02-45be-b08c-890fd9a33ad1)

## Optional in editor pathfinding debug

![editor_debug](https://github.com/user-attachments/assets/178e1b13-6d5f-4aae-89d3-c5fc1e794f22)

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

