extends Area
class_name Orb

export(int, "Neutral", "Fire", "Ice") var element = "Neutral"


func _on_Orb_body_entered(body: Node) -> void:
	if body is Elemental:
		body.change_element(element)
