extends Spatial
class_name Entity

signal nature(boost)
signal earth(boost)
signal fire(boost)
signal ice(boost)
signal wind(boost)
signal water(boost)
signal thunder(boost)
signal light(boost)
signal dark(boost)

var boost := ""

export(Array, String) var broadcast := []

var elements_sent := []


func send(element: String, boosted := false) -> void:
	if elements_sent.has(element):
		return

	elements_sent.append(element)
	emit_signal(element, boosted or boost == element)


func receive_from(entity: Entity) -> void:
	if not entity: return
	entity.connect("nature", self, "_nature")
	entity.connect("earth", self, "_earth")
	entity.connect("fire", self, "_fire")
	entity.connect("ice", self, "_ice")
	entity.connect("wind", self, "_wind")
	entity.connect("water", self, "_water")
	entity.connect("thunder", self, "_thunder")
	entity.connect("light", self, "_light")
	entity.connect("dark", self, "_dark")


func disconnect_from(entity: Entity) -> void:
	if not entity: return
	entity.disconnect("nature", self, "_nature")
	entity.disconnect("earth", self, "_earth")
	entity.disconnect("fire", self, "_fire")
	entity.disconnect("ice", self, "_ice")
	entity.disconnect("wind", self, "_wind")
	entity.disconnect("water", self, "_water")
	entity.disconnect("thunder", self, "_thunder")
	entity.disconnect("light", self, "_light")
	entity.disconnect("dark", self, "_dark")


func tick() -> void:
	for element in broadcast:
		send(element)

	elements_sent.clear()


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
