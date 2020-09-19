extends Terrain

func _ready() -> void:
	anim.play("idle")
	._ready()


func animate() -> void:
	anim.play("spawn")
	anim.queue("idle")


func _on_moved(map) -> void:
	pass


func _is_blocked(state: String) -> bool:
	return true
