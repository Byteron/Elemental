extends Character
class_name Creature

export var alias := ""
export(String, "Walker") var behavior := "Walker"


func _ready() -> void:
	._ready()


func tick() -> void:
	.tick()
