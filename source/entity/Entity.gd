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
	entity.connect("nature", self, "_nature")
	entity.connect("earth", self, "_earth")
	entity.connect("fire", self, "_fire")
	entity.connect("ice", self, "_ice")
	entity.connect("wind", self, "_wind")
	entity.connect("water", self, "_water")
	entity.connect("thunder", self, "_thunder")


func broadcast_to(entity: Entity) -> void:
	connect("nature", entity, "_nature")
	connect("earth", entity, "_earth")
	connect("fire", entity, "_fire")
	connect("ice", entity, "_ice")
	connect("wind", entity, "_wind")
	connect("water", entity, "_water")
	connect("thunder", entity, "_thunder")


func disconnect_from(entity: Entity) -> void:
	entity.disconnect("nature", self, "_nature")
	entity.disconnect("earth", self, "_earth")
	entity.disconnect("fire", self, "_fire")
	entity.disconnect("ice", self, "_ice")
	entity.disconnect("wind", self, "_wind")
	entity.disconnect("water", self, "_water")
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
