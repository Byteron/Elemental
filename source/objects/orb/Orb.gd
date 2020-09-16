extends Spatial
class_name Orb

signal collected()

export var alias := "Stone"

onready var mesh_instance := $MeshInstance as MeshInstance


func collect() -> void:
	emit_signal("collected")
	queue_free()
