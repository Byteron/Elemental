extends Terrain

func _ready() -> void:
	anim.play("idle")
	._ready()


func animate() -> void:
	.animate()
	anim.queue("idle")


func _is_blocked(state: int) -> bool:
	return true


func _earth() -> void:
	change("Cloud")
