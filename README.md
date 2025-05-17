## Godot A* Pathfinding for Gridmaps - Template and Tutorial

![AStar for Gridmaps](https://github.com/user-attachments/assets/2cba055a-ff00-4fe5-854b-71864ca1188e)

Easy A* pathfinding template and tutorial for Godot's GridMaps.

The video tutorial can be viewed on YouTube here: https://youtu.be/t4-R5tmFakw

This solution is great for 3D Dungeon Crawler games where you need to do pathfinding in discrete amounts in a grid pattern.

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

