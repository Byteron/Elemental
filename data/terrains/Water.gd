extends Terrain


func _is_blocked(state: String) -> bool:
	if state == "Water":
		return false
	return true


func _ice() -> void:
	change("Ice")


func _thunder() -> void:
	send("thunder")
