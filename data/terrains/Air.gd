extends Terrain


func _on_moved(map) -> void:
	pass


func _is_blocked(state: String) -> bool:
	if state != "Air":
		return true
	return false
