extends Entity
class_name Obstacle

signal destroyed()

export var alias := ""
export var particles : PackedScene = null

onready var anim := $AnimationPlayer as AnimationPlayer


func destroy() -> void:
	SFX.play_sfx("Burn")
	emit_signal("destroyed")
	anim.play("shrink")
	var p : Spatial = particles.instance() as Spatial
	p.global_transform.origin = global_transform.origin
	get_tree().current_scene.add_child(p)
	yield(anim, "animation_finished")
	queue_free()
