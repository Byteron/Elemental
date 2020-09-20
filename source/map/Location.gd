class_name Location

signal terrain_changed()

var cell := Vector3()
var position := Vector3()

var elemental : Elemental = null

var terrain : Terrain = null setget _set_terrain
var orb : Orb = null setget _set_orb
var seeds : Seeds = null setget _set_seeds
var obstacle : Obstacle = null setget _set_obstacle


func is_blocked(state: String) -> bool:
	if obstacle or (terrain and terrain.is_blocked(state)):
		return true
	return false


func _set_terrain(value: Terrain) -> void:
	if terrain:
		terrain.destroy()

	terrain = value

	if terrain:
		terrain.transform.origin = position


func _set_orb(value: Orb) -> void:
	if orb:
		orb.queue_free()

	orb = value

	if orb:
		#orb.transform.origin = position
		orb.connect("collected", self, "_on_orb_collected")


func _set_seeds(value: Seeds) -> void:
	if seeds:
		seeds.destroy()

	seeds = value

	if seeds:
		#seeds.transform.origin = position
		seeds.connect("collected", self, "_on_seeds_collected")


func _set_obstacle(value: Obstacle) -> void:
	if obstacle:
		obstacle.queue_free()

	obstacle = value

	if obstacle:
		#obstacle.transform.origin = position
		obstacle.connect("destroyed", self, "_on_obstacle_destroyed")


func _on_orb_collected() -> void:
	orb = null


func _on_seeds_collected() -> void:
	seeds = null


func _on_obstacle_destroyed() -> void:
	obstacle = null


