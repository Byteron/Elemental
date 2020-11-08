class_name Behavior

var map: Map = null

var creatures := []


func add_creature(creature: Creature) -> void:
	creatures.append(creature)


func execute() -> void:
	for creature in creatures:
		_execute(map, map.character_locations[creature], creature)


func _execute(map: Map, loc: Location, creature: Creature) -> void:
	pass
