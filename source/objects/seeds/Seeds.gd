extends Spatial
class_name Seeds

signal collected()


onready var mesh_instance := $MeshInstance as MeshInstance


static func instance() -> Seeds:
	return load("res://source/objects/seeds/Seeds.tscn").instance() as Seeds


func collect() -> void:
	emit_signal("collected")
	queue_free()
