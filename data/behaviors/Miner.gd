extends Behavior


func _execute(map: Map, loc: Location, creature: Creature) -> void:

	var walkable = map.find_walkable_locations(loc, creature.walkable)
	var ore_locs := map.find_adjacent_obstacles(walkable, "Ore")

	var ore_loc : Location = ore_locs.pop_front()
	var candle_loc := map.find_location_with_item_from_reachable(walkable, "Candle")

	if creature.has_candle:
		if ore_loc:
			if map.are_locations_neighbors(loc, ore_loc):
				ore_loc.obstacle.destroy()
			else:
				map.move_character_with_path(loc, ore_loc)
		elif creature.has_path():
			if loc.cell == creature.get_path_cell():
				_follow_path(map, loc, creature)
			else:
				map.move_character_with_path(loc, map.get_location(creature.get_path_cell()))
		else:
			map.move_character_with_path(loc, map.get_location(creature.start_cell))
	else:
		if candle_loc and candle_loc.item.is_lit:
			if candle_loc == loc:
				candle_loc.item.destroy()
				creature.has_candle = true
				creature.candle.visible = true
				creature.candle._fire(false)
			else:
				map.move_character_with_path(loc, candle_loc)
		elif creature.has_path():
			if loc.cell == creature.get_path_cell():
				_follow_path(map, loc, creature)
			else:
				map.move_character_with_path(loc, map.get_location(creature.get_path_cell()))
		else:
			map.move_character_with_path(loc, map.get_location(creature.start_cell))

func _follow_path(map: Map, loc: Location, creature: Creature) -> void:
	var next_cell : Vector3 = creature.get_next_path_cell()
	var next_loc := map.get_location(next_cell)

	if map.move_character(loc, next_loc):
		creature.increment_path_index()
