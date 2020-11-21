extends Behavior


func _execute(map: Map, loc: Location, creature: Creature) -> void:
	if not creature.path.size() > 1:
		print("Walker has no path")
		return

	var next_cell : Vector3 = creature.get_next_path_cell()
	var next_loc := map.get_location(next_cell)

	if map.move_character(loc, next_loc):
		creature.increment_path_index()
