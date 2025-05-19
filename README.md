## Godot A* Pathfinding for Gridmaps Plugin

<img src="https://github.com/user-attachments/assets/698771ce-eaa8-47ee-b058-78808bdd1a59" width="960" height="540">

An extended version of Godot's GridMap node that adds A* Pathfinding and in editor debugging.

Now implemented as a plugin.

This solution is great for 3D Dungeon Crawler games where you need to do pathfinding in discrete amounts in a grid pattern.

![plugin](https://github.com/user-attachments/assets/1a947054-8eea-46b6-9985-6f3170a0c0a3)
![is_in](https://github.com/user-attachments/assets/9bf1be71-7188-40f1-afae-2ff6da5dea19)
![editor_debug](https://github.com/user-attachments/assets/178e1b13-6d5f-4aae-89d3-c5fc1e794f22)
![no_selected](https://github.com/user-attachments/assets/ad212ab6-8c02-45be-b08c-890fd9a33ad1)
![New_inspect](https://github.com/user-attachments/assets/f0e5eac8-e7bf-44b5-9280-df13faa6b7b5)
![all_inspect](https://github.com/user-attachments/assets/4dd871a6-7210-4539-8bd8-af5797875c31)
![not_in](https://github.com/user-attachments/assets/9fe8d90c-8c7c-4bbf-9b83-57fcb42e4793)




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

