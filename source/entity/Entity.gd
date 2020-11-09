extends Spatial
class_name Entity

enum Element { NATURE, EARTH, FIRE, ICE, WIND, WATER, THUNDER, LIGHT, DARK, NONE }

export(Array, Element) var broadcast := []
export(Array, Element) var conduct := []


var boost : int = Element.NONE


func _nature(boosted: bool) -> void:
	pass


func _earth(boosted: bool) -> void:
	pass


func _fire(boosted: bool) -> void:
	pass


func _ice(boosted: bool) -> void:
	pass


func _wind(boosted: bool) -> void:
	pass


func _water(boosted: bool) -> void:
	pass


func _thunder(boosted: bool) -> void:
	pass


func _light(boosted: bool) -> void:
	pass


func _dark(boosted: bool) -> void:
	pass
