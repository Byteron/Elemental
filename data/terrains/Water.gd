extends Terrain


func _is_blocked(state: int) -> bool:
	if state == Entity.Element.WATER:
		return false
	return true


func _ice(boosted: bool) -> void:
	change("Ice")
