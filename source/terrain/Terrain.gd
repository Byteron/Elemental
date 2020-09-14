extends Area
class_name Terrain

enum Action {
	MOVE,
	BLOCK,
	FALL,
}

export var alias := ""
export var fertile := false

export(Array, Resource) var transitions = []

var cell := Vector3()
var position := Vector3()


func on_moved(map) -> void:
	_on_moved(map)


func is_blocked(state: String) -> bool:
	return _is_blocked(state)


func _on_moved(map) -> void:
	pass


func _is_blocked(state: String) -> bool:
	return true
