extends Character
class_name Creature

export var alias := ""

export(String, "None", "Walker", "Eater") var behavior := "Walker"

export(Array, String) var walkable := []


func tick() -> void:
	.tick()
