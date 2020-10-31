extends Terrain


func _water(boosted: bool) -> void:
	change("BrittleStone")


func _is_blocked(state: int) -> bool:
	if state == Elemental.State.FIRE:
		return false
	return true
