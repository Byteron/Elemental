extends Area
class_name Orb

signal collected

export(String, "Neutral", "Fire", "Ice") var element = "Neutral"

onready var mesh_instance := $MeshInstance as MeshInstance


static func instance() -> Orb:
	return load("res://source/objects/orb/Orb.tscn").instance() as Orb


func _on_Orb_area_entered(area: Area) -> void:
	if area is Elemental:
		area.state = element
		area.mesh_instance.material_override = Global.orb_materials.get(element.to_lower())
		print("Elemental State: ", element)
		emit_signal("collected")
		queue_free()
