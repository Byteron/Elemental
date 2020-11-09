extends Terrain


func _is_blocked(state: int) -> bool:
	if state != Entity.Element.LIGHT:
		return true
	return false
