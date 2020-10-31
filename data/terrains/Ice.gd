extends Terrain


func _is_blocked(state: int) -> bool:
	if state == Elemental.State.FIRE:
		return true
	return false


func _fire(boosted: bool) -> void:
	change("Water")
