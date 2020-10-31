extends Terrain


func _is_blocked(state: int) -> bool:
	if state == Elemental.State.WATER:
		return false
	return true


func _ice() -> void:
	change("Ice")


func _thunder() -> void:
	send("thunder")
