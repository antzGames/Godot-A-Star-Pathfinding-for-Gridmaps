## Godot A* Pathfinding for Gridmaps - Template and Tutorial

Easy A* pathfinding template and tutorial for Godot's GridMaps.

The video tutorial can be viewed on YouTube here: https://youtu.be/t4-R5tmFakw

## GridMap location to world space and vice versa

One of the things I should have discussed in the tutorial video is that GridMap co-ordinate system is not the same as the world space.

You need to covert GridMap locations to world space with:

`grid_map.map_to_local(map_position: Vector3i) -> Vector3`

And coverting world locations to GridMap locations with:

`grid_map.local_to_map(local_position: Vector3) -> Vector3i`



