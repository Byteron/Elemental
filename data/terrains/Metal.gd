extends Terrain


func _thunder(boosted: bool) -> void:
	send("thunder")


func _fire(boosted: bool) -> void:
	send("fire")
