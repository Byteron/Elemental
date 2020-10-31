extends Terrain


func _is_blocked(state: int) -> bool:
	return false


func _fire() -> void:
	change("Earth")
