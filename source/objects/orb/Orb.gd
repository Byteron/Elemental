extends Area
class_name Orb

signal collected

export(String, "Stone", "Fire", "Ice", "Air") var element = "Stone"

onready var mesh_instance := $MeshInstance as MeshInstance


static func instance() -> Orb:
	return load("res://source/objects/orb/Orb.tscn").instance() as Orb


func _on_Orb_area_entered(area: Area) -> void:
	if area is Elemental:
		if element == "Fire" and area.seeds:
			get_tree().reload_current_scene()
			return

		area.state = element
		area.mesh_instance.material_override = Global.orb_materials.get(element.to_lower())
		print("Elemental State: ", element)
		emit_signal("collected")
		queue_free()
