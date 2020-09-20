extends Spatial
class_name Obstacle

signal destroyed()

export var alias := ""

onready var anim := $AnimationPlayer as AnimationPlayer


func destroy() -> void:
	SFX.play_sfx("Burn")
	emit_signal("destroyed")
	anim.play("shrink")
	yield(anim, "animation_finished")
	queue_free()


func is_destroyable(state: String) -> bool:
	return _is_destroyable(state)


func _is_destroyable(state: String) -> bool:
	return false
