extends Terrain


func _is_blocked(state: int) -> bool:
	if state != Elemental.State.DARK:
		return true
	return false
