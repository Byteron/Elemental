extends Behavior


func _execute(map: Map, loc: Location, creature: Creature) -> void:
	var neighbors = map.get_neighbors(loc)
	map.move_character(loc, neighbors[randi() % neighbors.size()])
