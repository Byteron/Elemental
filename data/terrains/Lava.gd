extends Terrain


func _water() -> void:
	change("BrittleStone")


func _is_blocked(state: int) -> bool:
	if state == Elemental.State.FIRE:
		return false
	return true
