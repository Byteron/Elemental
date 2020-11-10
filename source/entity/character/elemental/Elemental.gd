extends Character
class_name Elemental

export(Entity.Element) var state := 1 setget _set_state

var inventory := {}

onready var vfx_picker := $ElementalVFXPicker

onready var mesh_instance := $Meshes/MeshInstance as MeshInstance

onready var item_container := $Items as Spatial


func _ready() -> void:
	_set_state(state)
	meshes.rotation_degrees.y = 135
	inventory.clear()


func add_item(alias: String) -> void:
	if not inventory.has(alias):
		inventory[alias] = 0
	inventory[alias] += 1
	print("%s: %d" % [alias, inventory[alias]])
	update_inventory()


func remove_item(alias: String) -> void:
	if not inventory.has(alias):
		return

	inventory[alias] -= 1

	if inventory[alias] == 0:
		inventory.erase(alias)
		print("%s: %d" % [alias, 0])
	else:
		print("%s: %d" % [alias, inventory[alias]])
	update_inventory()


func get_item_count(alias: String) -> int:
	if inventory.has(alias):
		return inventory[alias]
	return 0


func plop() -> void:
	tween.interpolate_property(self, "scale", Vector3(1, 1, 1), Vector3(0.8, 1.2, 0.8), 0.15, Tween.TRANS_SINE, Tween.EASE_IN)
	tween.interpolate_property(self, "scale", Vector3(0.8, 1.2, 0.8), Vector3(1, 1, 1), 0.2, Tween.TRANS_BACK, Tween.EASE_OUT, 0.15)
	tween.start()


func shake() -> void:
	tween.interpolate_property(self, "rotation_degrees:y", rotation_degrees.y, rotation_degrees.y - 20, 0.1, Tween.TRANS_SINE, Tween.EASE_IN)
	tween.interpolate_property(self, "rotation_degrees:y", rotation_degrees.y - 20, rotation_degrees.y + 20, 0.1, Tween.TRANS_SINE, Tween.EASE_IN, 0.1)
	tween.interpolate_property(self, "rotation_degrees:y", rotation_degrees.y + 20, rotation_degrees.y, 0.1, Tween.TRANS_SINE, Tween.EASE_IN, 0.2)
	tween.start()


func finished() -> void:
	meshes.rotation_degrees.y = 135
	anim.play("finished")


func _clear_items() -> void:
	for child in item_container.get_children():
		item_container.remove_child(child)
		child.queue_free()


func update_inventory() -> void:
	_clear_items()

	var items := []
	for key in inventory:
		var count : int = inventory[key]
		for i in count:
			items.append(Global.items[key].instance())

	for i in items.size():
		var item = items[i]
		var spatial = Spatial.new()
		item_container.add_child(spatial)
		spatial.add_child(item)
		item.translate_object_local(Vector3.FORWARD * 1.25)
		spatial.rotation_degrees.y = (360 / items.size()) * i


func _set_state(value: int) -> void:
	state = value

	vfx_picker.activate_particles(state)

	var state_name : String = Entity.Element.keys()[state].to_lower()

	broadcast = [ state ]

	mesh_instance.mesh = vfx_picker.get_mesh(state_name)
	mesh_instance.material_override = vfx_picker.get_material(state_name)


