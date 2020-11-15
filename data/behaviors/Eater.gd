extends Behavior


func _execute(map: Map, loc: Location, creature: Creature) -> void:
	var reachable = map.find_walkable_locations(loc, creature.walkable)

	var meat_loc = map.find_location_with_item_from_reachable(reachable, "Meat")

	if meat_loc == loc:
		loc.item.destroy()
	elif meat_loc:
		map.move_character_with_path(loc, meat_loc)
	elif loc.cell != creature.start_cell:
		var start_loc = map.get_location(creature.start_cell)
		map.move_character_with_path(loc, start_loc)



