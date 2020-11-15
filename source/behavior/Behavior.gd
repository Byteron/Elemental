class_name Behavior

var map: Map = null

var creatures := []


func add_creature(creature: Creature) -> void:
	creatures.append(creature)
	creature.connect("died", self, "_on_creature_died")


func execute() -> void:
	for creature in creatures:

		if not creature:
			continue

		_execute(map, map.character_locations[creature], creature)


func _execute(map: Map, loc: Location, creature: Creature) -> void:
	pass


func  _on_creature_died(creature: Creature) -> void:
	creatures.erase(creature)
