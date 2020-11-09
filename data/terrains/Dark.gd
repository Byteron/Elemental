extends Terrain


func _is_blocked(state: int) -> bool:
	if state != Entity.Element.DARK:
		return true
	return false
