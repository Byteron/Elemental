extends Node
class_name Location

signal terrain_changed()

var cell := Vector3()
var position := Vector3()

var elemental : Elemental = null

var terrain : Terrain = null setget _set_terrain
var orb : Orb = null setget _set_orb
var seeds : Seeds = null setget _set_seeds


func _set_terrain(value: Terrain) -> void:
	if terrain:
		terrain.queue_free()

	terrain = value

	if terrain:
		terrain.transform.origin = position


func _set_orb(value: Orb) -> void:
	if orb:
		orb.queue_free()

	orb = value

	if orb:
		orb.transform.origin = position
		orb.connect("collected", self, "_on_orb_collected")


func _set_seeds(value: Seeds) -> void:
	if seeds:
		seeds.queue_free()

	seeds = value

	if seeds:
		seeds.transform.origin = position
		seeds.connect("collected", self, "_on_seeds_collected")


func _on_orb_collected() -> void:
	orb = null


func _on_seeds_collected() -> void:
	seeds = null


