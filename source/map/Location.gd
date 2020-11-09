extends Entity
class_name Location

signal hovered(loc)

var cell := Vector3()
var position := Vector3()

var character : Character = null

var terrain : Terrain = null setget _set_terrain
var orb : Orb = null setget _set_orb
var sigil : Sigil = null setget _set_sigil
var seeds : Seeds = null setget _set_seeds
var obstacle : Obstacle = null setget _set_obstacle

var initialized := false


func get_broadcast() -> Array:
	var elements := []

	_add_broadcaster(elements, character)
	_add_broadcaster(elements, terrain)
	_add_broadcaster(elements, obstacle)
	_add_broadcaster(elements, seeds)
	_add_broadcaster(elements, self)

	return elements


func get_conduction() -> Array:
	if terrain:
		return terrain.conduct
	return []


func change_terrain(alias: String) -> void:
	_on_terrain_changed(alias)


func is_blocked(state: int) -> bool:
	if obstacle or character or (terrain and terrain.is_blocked(state)):
		return true
	return false


func conducts_element(element: int) -> bool:
	if not terrain:
		return false
	return terrain.conducts_element(element)


func _add_broadcaster(elements: Array, entity: Entity) -> void:
	if not entity:
		return

	for element in entity.broadcast:
		if not elements.has(element):
			elements.append(element)


func _call_on_children(function: String, boosted: bool) -> void:
	if character:
		character.call(function, boosted)
	if terrain:
		terrain.call(function, boosted)
	if obstacle:
		obstacle.call(function, boosted)
	if seeds:
		seeds.call(function, boosted)


func _set_terrain(value: Terrain) -> void:
	if terrain:
		terrain.queue_free()

	terrain = value

	if terrain:
		terrain.connect("hovered", self, "_on_terrain_hovered")
		terrain.connect("changed", self, "_on_terrain_changed")
		add_child(terrain)

		if initialized:
			terrain.animate()

	initialized = true


func _set_orb(value: Orb) -> void:
	if orb:
		orb.queue_free()

	orb = value

	if orb:
		terrain.add_child(orb)
		orb.connect("collected", self, "_on_orb_collected")


func _set_sigil(value: Sigil) -> void:
	if sigil:
		sigil.queue_free()

	sigil = value

	if sigil:
		terrain.add_child(sigil)


func _set_seeds(value: Seeds) -> void:
	if seeds:
		seeds.queue_free()

	seeds = value

	if seeds:
		terrain.add_child(seeds)
		seeds.connect("collected", self, "_on_seeds_collected")


func _set_obstacle(value: Obstacle) -> void:
	if obstacle:
		obstacle.queue_free()

	obstacle = value

	if obstacle:
		terrain.add_child(obstacle)
		obstacle.connect("destroyed", self, "_on_obstacle_destroyed")


func _nature(boosted: bool) -> void:
	_call_on_children("_nature", boosted)


func _earth(boosted: bool) -> void:
	_call_on_children("_earth", boosted)


func _fire(boosted: bool) -> void:
	_call_on_children("_fire", boosted)


func _ice(boosted: bool) -> void:
	_call_on_children("_ice", boosted)


func _wind(boosted: bool) -> void:
	_call_on_children("_wind", boosted)


func _water(boosted: bool) -> void:
	_call_on_children("_water", boosted)


func _thunder(boosted: bool) -> void:
	_call_on_children("_thunder", boosted)


func _light(boosted: bool) -> void:
	_call_on_children("_light", boosted)


func _dark(boosted: bool) -> void:
	_call_on_children("_dark", boosted)


func _on_terrain_hovered() -> void:
	emit_signal("hovered", self)


func _on_terrain_changed(alias: String) -> void:
	var terrain = Global.terrains[alias].instance()
	_set_terrain(terrain)


func _on_orb_collected() -> void:
	orb = null


func _on_seeds_collected() -> void:
	seeds = null


func _on_obstacle_destroyed() -> void:
	obstacle = null
