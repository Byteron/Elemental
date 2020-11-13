extends Behavior


func _execute(map: Map, loc: Location, creature: Creature) -> void:
	var reachable = map.find_walkable_locations(loc, creature.walkable)

	var end_loc : Location = null

	for loc in reachable:
		if loc.item and loc.item.alias == "Meat":
			end_loc = loc
			break

	if not end_loc:
		return

	if end_loc == loc:
		loc.item.destroy()
		return

	map.update_grid_weight(creature.walkable)

	var path = map.find_path(loc, end_loc)

	var next_loc: Location = path.pop_front()

	if not next_loc:
		return

	var __ = map.move_character(loc, next_loc)
