extends Terrain


func _on_moved(map) -> void:
	pass


func _is_blocked(state: String) -> bool:
	if state != "Ice":
		return true
	return false
