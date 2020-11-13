extends Behavior


func _execute(map: Map, loc: Location, creature: Creature) -> void:
	if not creature.path.size() > 1:
		print("Walker has no path")
		return

	var next_cell : Vector3 = creature.path[creature.next_path_index]
	var next_loc := map.get_location(next_cell)

	if map.move_character(loc, next_loc):
		_increment_path_index(creature)


func _increment_path_index(creature: Creature) -> void:
	if creature.walk_reverse:
		creature.next_path_index -= 1

		if creature.next_path_index == -1:
			creature.next_path_index = 1
			creature.walk_reverse = false
	else:
		creature.next_path_index += 1

		if creature.path.size() == creature.next_path_index:
			if creature.loop_path:
				creature.next_path_index = 0
			else:
				creature.walk_reverse = !creature.walk_reverse
				creature.next_path_index -= 2
