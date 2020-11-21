extends Terrain


func _is_blocked(state: int) -> bool:
	return true


func _fire(boosted: bool) -> void:
	change("Earth")
