extends Area
class_name Seeds

signal collected()


onready var mesh_instance := $MeshInstance as MeshInstance


static func instance() -> Seeds:
	return load("res://source/objects/seeds/Seeds.tscn").instance() as Seeds


func _on_Seeds_area_entered(area: Area) -> void:
	if area is Elemental:
		if area.state != "Fire":
			area.seeds += 1
			print("Seeds + 1")
		emit_signal("collected")
		queue_free()
