extends Terrain


func _is_blocked(state: String) -> bool:
	return false


func _fire() -> void:
	change("Water")
