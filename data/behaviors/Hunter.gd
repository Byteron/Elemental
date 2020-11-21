extends Behavior


func _execute(map: Map, loc: Location, creature: Creature) -> void:

	var reachable = map.find_walkable_locations(loc, creature.walkable)

	var meat_loc = map.find_location_with_item_from_reachable(reachable, "Meat")

	if meat_loc == loc:
		loc.item.destroy()
	elif meat_loc:
		map.move_character_with_path(loc, meat_loc)
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
