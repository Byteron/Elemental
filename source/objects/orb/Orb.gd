extends Spatial
class_name Orb

signal collected()

export(Elemental.State) var element := 0

onready var mesh_instance := $MeshInstance as MeshInstance


func _process(delta: float) -> void:
	rotation_degrees.y += 20.0 * delta


func collect() -> void:
	var alias = Elemental.State.keys()[element].to_lower().capitalize()

	SFX.play_sfx(alias + "Orb")

	match alias:
		"Earth":
			Music.play_track(1, .5)
			Music.stop_track(2, .5)
			Music.stop_track(3, .5)
			Music.stop_track(3, .5)
			Music.stop_track(4, .5)
		"Ice":
			Music.play_track(2, .5)
			Music.stop_track(1, .5)
			Music.stop_track(3, .5)
			Music.stop_track(4, .5)
			Music.stop_track(5, .5)
		"Fire":
			Music.play_track(3, .5)
			Music.stop_track(1, .5)
			Music.stop_track(2, .5)
			Music.stop_track(4, .5)
			Music.stop_track(5, .5)
		"Water":
			Music.play_track(4, .5)
			Music.stop_track(1, .5)
			Music.stop_track(2, .5)
			Music.stop_track(3, .5)
			Music.stop_track(5, .5)
		"Wind":
			Music.play_track(5, .5)
			Music.stop_track(1, .5)
			Music.stop_track(2, .5)
			Music.stop_track(3, .5)
			Music.stop_track(4, .5)

	emit_signal("collected")
	queue_free()
