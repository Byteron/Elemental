extends Behavior


func _execute(map: Map, loc: Location, creature: Creature) -> void:
	var walkable = map.find_walkable_locations(loc, creature.walkable)
	var neighbors = map.get_neighbors(loc)

	var next_loc = neighbors[randi() % neighbors.size()]

	if next_loc.get_terrain_alias() in walkable:
		var __ = map.move_character(loc, next_loc)
