extends Obstacle


func _is_destroyable(state: String) -> bool:
	if state == "Fire":
		return true
	return false
