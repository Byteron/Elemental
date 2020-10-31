extends Terrain


func _thunder(boosted: bool) -> void:
	send("thunder", boosted)
