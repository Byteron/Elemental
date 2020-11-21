extends Behavior


func _execute(map: Map, loc: Location, creature: Creature) -> void:

	var reachable = map.find_walkable_locations(loc, creature.walkable)

	var search_loc : Location = null

	if creature.has_candle:
		var ore_locs := map.find_adjacent_obstacles(reachable, "Ore")
		search_loc = ore_locs.pop_front()
	else:
		search_loc = map.find_location_with_item_from_reachable(reachable, "Candle")

	if creature.has_candle and map.are_locations_neighbors(loc, search_loc):
		search_loc.obstacle.destroy()
	elif search_loc == loc:
		loc.item.destroy()
		creature.has_candle = true
	elif search_loc:
		map.move_character_with_path(loc, search_loc)

	elif creature.path.size() < 2:
		if loc.cell != creature.start_cell:
			var start_loc = map.get_location(creature.start_cell)
			map.move_character_with_path(loc, start_loc)

	elif loc.cell != creature.get_path_cell():
		var path_loc = map.get_location(creature.get_path_cell())
		map.move_character_with_path(loc, path_loc)

	else:
		_follow_path(map, loc, creature)


func _follow_path(map: Map, loc: Location, creature: Creature) -> void:
	var next_cell : Vector3 = creature.get_next_path_cell()
	var next_loc := map.get_location(next_cell)

	if map.move_character(loc, next_loc):
		creature.increment_path_index()
