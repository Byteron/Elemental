extends Entity
class_name Item

signal collected()
signal destroyed()

export var alias := ""
export var collected_sfx := "GrabSeeds"
export var destroy_particles : PackedScene = null

onready var anim := $AnimationPlayer as AnimationPlayer


func destroy() -> void:
	emit_signal("destroyed")

	if destroy_particles:
		var p : Spatial = destroy_particles.instance() as Spatial
		get_tree().current_scene.add_child(p)
		p.global_transform.origin = global_transform.origin

	anim.play("shrink")

	yield(anim, "animation_finished")

	queue_free()


func collect() -> void:
	SFX.play_sfx(collected_sfx)
	emit_signal("collected")
	queue_free()
