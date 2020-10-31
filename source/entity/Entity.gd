extends Spatial
class_name Entity

signal nature()
signal earth()
signal fire()
signal ice()
signal wind()
signal water()
signal thunder()


export(Array, String) var broadcast := []

var elements_sent := []


func send(element: String) -> void:
	if elements_sent.has(element):
		return

	elements_sent.append(element)
	emit_signal(element)


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

func _nature() -> void:
	pass


func _earth() -> void:
	pass


func _fire() -> void:
	pass


func _ice() -> void:
	pass


func _wind() -> void:
	pass


func _water() -> void:
	pass


func _thunder() -> void:
	pass
