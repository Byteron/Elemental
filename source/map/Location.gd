extends Spatial
class_name Location

signal hovered(loc)
signal terrain_changed(loc)

var cell := Vector3()
var position := Vector3()

var elemental : Elemental = null

var terrain : Terrain = null setget _set_terrain
var orb : Orb = null setget _set_orb
var seeds : Seeds = null setget _set_seeds
var obstacle : Obstacle = null setget _set_obstacle

var initialized := false


func change_terrain(alias: String) -> void:
	_on_terrain_change(alias)


func tick() -> void:
	if terrain:
		terrain.tick()


func receive_from(entity: Entity) -> void:
	if terrain:
		terrain.receive_from(entity)
	if obstacle:
		obstacle.receive_from(entity)
	if seeds:
		seeds.receive_from(entity)


func broadcast_to(entity: Entity) -> void:
	if terrain:
		terrain.broadcast_to(entity)
	if obstacle:
		obstacle.broadcast_to(entity)
	if seeds:
		seeds.broadcast_to(entity)


func disconnect_from(entity: Entity) -> void:
	if terrain:
		terrain.disconnect_from(entity)
	if obstacle:
		obstacle.disconnect_from(entity)
	if seeds:
		seeds.disconnect_from(entity)


func is_blocked(state: String) -> bool:
	if obstacle or (terrain and terrain.is_blocked(state)):
		return true
	return false


func _set_terrain(value: Terrain) -> void:
	if terrain:
		terrain.queue_free()

	terrain = value

	if terrain:
		terrain.connect("hovered", self, "_on_terrain_hovered")
		terrain.connect("change", self, "_on_terrain_change")
		add_child(terrain)

		if initialized:
			terrain.animate()

	initialized = true


func _set_orb(value: Orb) -> void:
	if orb:
		orb.queue_free()

	orb = value

	if orb:
		add_child(orb)
		orb.connect("collected", self, "_on_orb_collected")


func _set_seeds(value: Seeds) -> void:
	if seeds:
		seeds.queue_free()

	seeds = value

	if seeds:
		add_child(seeds)
		seeds.connect("collected", self, "_on_seeds_collected")


func _set_obstacle(value: Obstacle) -> void:
	if obstacle:
		obstacle.queue_free()

	obstacle = value

	if obstacle:
		add_child(obstacle)
		obstacle.connect("destroyed", self, "_on_obstacle_destroyed")


func _on_terrain_hovered() -> void:
	emit_signal("hovered", self)


func _on_terrain_change(alias: String) -> void:
	var terrain = Global.terrains[alias].instance()
	_set_terrain(terrain)
	emit_signal("terrain_changed", self)


func _on_orb_collected() -> void:
	orb = null


func _on_seeds_collected() -> void:
	seeds = null


func _on_obstacle_destroyed() -> void:
	obstacle = null


