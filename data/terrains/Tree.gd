extends Terrain


func _on_moved(map) -> void:
	if map.elemental.state == "Fire":
		get_tree().reload_current_scene()


func _is_blocked(state: String) -> bool:
	return false
