extends Character
class_name Creature

export var alias := ""

export(String, "None", "Walker", "Eater", "Stray", "Stranded", "Scared") var behavior := "Walker"

export(Array, String) var walkable := []

# General
var start_cell := Vector3()

# Walker
var path := []
var next_path_index := 1
var walk_reverse := false
var loop_path = false


func tick() -> void:
	.tick()
