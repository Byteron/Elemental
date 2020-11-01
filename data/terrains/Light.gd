extends Terrain


func _is_blocked(state: int) -> bool:
	if state != Elemental.State.LIGHT:
		return true
	return false
