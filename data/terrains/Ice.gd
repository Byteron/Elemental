extends Terrain


func _is_blocked(state: int) -> bool:
	if state == Elemental.State.FIRE:
		return true
	return false


func _fire() -> void:
	change("Water")
