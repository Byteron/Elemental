extends Character
class_name Creature

export var alias := ""
export(String, "Walker", "Eater") var behavior := "Walker"

export(Array, String) var walkable := []

func _ready() -> void:
	._ready()


func tick() -> void:
	.tick()
