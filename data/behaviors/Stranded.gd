extends Behavior


func _execute(map: Map, loc: Location, creature: Creature) -> void:
	var neighbors = map.get_neighbors(loc)

	var cell := Vector3()

	for n_loc in neighbors:
		if not n_loc.character:
			continue

		cell = n_loc.cell
		break

	if not cell:
		return

	var diff = loc.cell - cell
	var opposite_cell = loc.cell + diff
	var next_loc = map.get_location(opposite_cell)

	if next_loc:
		if map.move_character(loc, next_loc):
			if next_loc.terrain.alias == "Water":
				creature.kill()
