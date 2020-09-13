extends Area
class_name Orb

signal collected

export(int, "Neutral", "Fire", "Ice") var element = "Neutral"


func _on_Orb_area_entered(area: Area) -> void:
	if area is Elemental:
		area.state = element
		emit_signal("collected")
		queue_free()
