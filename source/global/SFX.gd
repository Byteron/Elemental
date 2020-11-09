extends SoundBooth


func play_element_sfx(element: int) -> void:
	var alias = Entity.Element.keys()[element].to_lower().capitalize()
	play_sfx(alias + "Orb")
