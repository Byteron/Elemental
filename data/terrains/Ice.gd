extends Terrain


func _is_blocked(state: String) -> bool:
	if state == "Fire":
		return true
	return false


func _fire() -> void:
	change("Water")
