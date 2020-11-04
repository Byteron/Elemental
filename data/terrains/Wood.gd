extends Terrain


func _fire(boosted: bool) -> void:
	yield(get_tree().create_timer(0.2), "timeout")
	send("fire")
	yield(get_tree().create_timer(0.2), "timeout")
	change("None")
