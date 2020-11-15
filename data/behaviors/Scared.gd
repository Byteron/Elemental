extends Behavior


func _execute(map: Map, loc: Location, creature: Creature) -> void:
	var reachable = map.find_walkable_locations(loc, creature.walkable)

	var exit_loc = map.find_location_with_terrain_from_reachable(reachable, "Grass")

	if exit_loc == loc:
		creature.kill()
	elif exit_loc:
		map.move_character_with_path(loc, exit_loc)
