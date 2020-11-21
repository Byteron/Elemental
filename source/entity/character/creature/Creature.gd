extends Character
class_name Creature

export var alias := ""

export(String, "None", "Walker", "Stray", "Stranded", "Scared", "Hunter", "Miner") var behavior := "Walker"

export(Array, String) var walkable := []

# General
var start_cell := Vector3()

# Scared
export var save_terrain := "Grass"

# Miner
var has_candle := false
onready var candle := $Meshes/Candle

# Walker
var path := []
var next_path_index := 1
var path_index := 0
var walk_reverse := false
var loop_path = false


func tick() -> void:
	.tick()


func get_next_path_cell() -> Vector3:
	return path[next_path_index]


func get_path_cell() -> Vector3:
	return path[path_index]


func increment_path_index() -> void:
	path_index = next_path_index

	if walk_reverse:
		next_path_index -= 1

		if next_path_index == -1:
			next_path_index = 1
			walk_reverse = false
	else:
		next_path_index += 1

		if path.size() == next_path_index:
			if loop_path:
				next_path_index = 0
			else:
				walk_reverse = !walk_reverse
				next_path_index -= 2
