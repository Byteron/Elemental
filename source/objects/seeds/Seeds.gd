extends Spatial
class_name Seeds

signal collected()


static func instance() -> Seeds:
	return load("res://source/objects/seeds/Seeds.tscn").instance() as Seeds


func collect() -> void:
	SFX.play_sfx("GrabSeeds")
	emit_signal("collected")
	queue_free()
