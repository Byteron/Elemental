extends Behavior


func _execute(map: Map, loc: Location, creature: Creature) -> void:
	var reachable = map.find_walkable_locations(loc, creature.walkable)

	var meat_loc = find_location_with_item("Meat", reachable)

	if meat_loc == loc:
		loc.item.destroy()
	elif meat_loc:
		move_to(loc, meat_loc)
	elif loc.cell != creature.start_cell:
		var start_loc = map.get_location(creature.start_cell)
		move_to(loc, start_loc)


func find_location_with_item(alias: String, reachable: Array) -> Location:
	var end_loc : Location = null

	for loc in reachable:
		if loc.item and loc.item.alias == alias:
			return loc

	return null


func move_to(loc: Location, end_loc: Location) -> void:
	map.update_grid_weight(loc.character.walkable)

	var path = map.find_path(loc, end_loc)

	var next_loc: Location = path.pop_front()

	if not next_loc:
		return

	var __ = map.move_character(loc, next_loc)
