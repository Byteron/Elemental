extends Terrain


func _thunder(boosted: bool) -> void:
	anim.play("conduct")
	yield(get_tree().create_timer(0.05), "timeout")
	send("thunder")


func _fire(boosted: bool) -> void:
	anim.play("conduct")
	yield(get_tree().create_timer(0.05), "timeout")
	send("fire")
