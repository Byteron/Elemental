extends Terrain


func _is_blocked(state: int) -> bool:
	if state == Elemental.State.WATER:
		return false
	return true


func _ice(boosted: bool) -> void:
	change("Ice")


func _thunder(boosted: bool) -> void:
	send("thunder", boosted)
