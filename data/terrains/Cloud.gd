extends Terrain


func _is_blocked(state: int) -> bool:
	if state != Entity.Element.WIND:
		return true
	return false
