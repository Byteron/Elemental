extends Spatial
class_name Orb

signal collected()

export(Elemental.State) var element := 0

onready var mesh_instance := $MeshInstance as MeshInstance


func _process(delta: float) -> void:
	rotation_degrees.y += 20.0 * delta


func collect() -> void:
	SFX.play_element_sfx(element)
	Music.play_element_music(element)

	emit_signal("collected")
	queue_free()
