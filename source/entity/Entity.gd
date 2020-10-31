extends Spatial
class_name Entity

signal nature(boost)
signal earth(boost)
signal fire(boost)
signal ice(boost)
signal wind(boost)
signal water(boost)
signal thunder(boost)

var boost := ""

export(Array, String) var broadcast := []

var elements_sent := []


func send(element: String, boosted := false) -> void:
	if elements_sent.has(element):
		return

	elements_sent.append(element)
	emit_signal(element, boosted or boost == element)
	boost = ""


func receive_from(entity: Entity) -> void:
	for element in entity.broadcast:
		entity.connect(element, self, "_" + element)


func broadcast_to(entity: Entity) -> void:
	for element in broadcast:
		connect(element, entity, "_" + element)


func disconnect_from(entity: Entity) -> void:
	if entity.is_connected("nature", self, "_nature"):
		entity.disconnect("nature", self, "_nature")

	if entity.is_connected("earth", self, "_earth"):
		entity.disconnect("earth", self, "_earth")

	if entity.is_connected("fire", self, "_fire"):
		entity.disconnect("fire", self, "_fire")

	if entity.is_connected("ice", self, "_ice"):
		entity.disconnect("ice", self, "_ice")

	if entity.is_connected("wind", self, "_wind"):
		entity.disconnect("wind", self, "_wind")

	if entity.is_connected("water", self, "_water"):
		entity.disconnect("water", self, "_water")

	if entity.is_connected("thunder", self, "_thunder"):
		entity.disconnect("thunder", self, "_thunder")


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
