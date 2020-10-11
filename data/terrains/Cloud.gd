extends Terrain


func _is_blocked(state: String) -> bool:
	if state != "Wind":
		return true
	return false
