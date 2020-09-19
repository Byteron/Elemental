extends Spatial
class_name Orb

signal collected()

export var alias := "Stone"

onready var mesh_instance := $MeshInstance as MeshInstance


func _process(delta: float) -> void:
	rotation_degrees.y += 20.0 * delta


func collect() -> void:
	SFX.play_sfx(alias + "Orb")
	emit_signal("collected")
	queue_free()
