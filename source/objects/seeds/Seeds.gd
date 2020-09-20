extends Spatial
class_name Seeds

signal collected()

onready var anim := $AnimationPlayer as AnimationPlayer


static func instance() -> Seeds:
	return load("res://source/objects/seeds/Seeds.tscn").instance() as Seeds


func destroy() -> void:
	emit_signal("collected")
	anim.play("shrink")
	yield(anim, "animation_finished")
	queue_free()


func collect() -> void:
	SFX.play_sfx("GrabSeeds")
	emit_signal("collected")
	queue_free()
