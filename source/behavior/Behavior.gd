class_name Behavior

var map: Map = null

var creatures := []


func add_creature(creature: Creature) -> void:
	creatures.append(creature)


func execute() -> void:
	for creature in creatures:
		var creature_loc: Location

		for cell in map.locations:
			var loc: Location = map.locations[cell]
			if loc.character and loc.character == creature:
				creature_loc = loc
				break

		if not creature_loc:
			print("creature has no location, that is weird")
			return

		_execute(map, creature_loc, creature)


func _execute(map: Map, loc: Location, creature: Creature) -> void:
	pass
