extends Terrain


func _is_blocked(state: int) -> bool:
	if state != Elemental.State.WIND:
		return true
	return false
