extends Entity
class_name Seeds

signal collected()

export var particles : PackedScene = null
onready var anim := $AnimationPlayer as AnimationPlayer


static func instance() -> Seeds:
	return load("res://source/objects/seeds/Seeds.tscn").instance() as Seeds


func _fire(boosted: bool) -> void:
	destroy()


func _ice(boosted: bool) -> void:
	destroy()


func destroy() -> void:
	emit_signal("collected")
	anim.play("shrink")
	var p : Spatial = particles.instance() as Spatial
	p.global_transform.origin = global_transform.origin
	get_tree().current_scene.add_child(p)
	yield(anim, "animation_finished")
	queue_free()


func collect() -> void:
	SFX.play_sfx("GrabSeeds")
	emit_signal("collected")
	queue_free()
