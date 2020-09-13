extends Area
class_name Seeds

signal collected()

func _on_Seeds_area_entered(area: Area) -> void:
	if area is Elemental:
		area.seeds += 1
		emit_signal("collected")
		queue_free()
