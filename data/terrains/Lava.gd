extends Terrain


func _water(boosted: bool) -> void:
	change("Obsidian")


func _is_blocked(state: int) -> bool:
	if state == Entity.Element.FIRE:
		return false
	return true
