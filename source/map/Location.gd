extends Node
class_name Location

signal terrain_changed()

var cell := Vector3()
var position := Vector3()

var terrain : Terrain = null
var elemental : Elemental = null

var orb : Orb = null setget _set_orb
var seeds : Seeds = null setget _set_seeds


func _set_orb(value: Orb) -> void:
	orb = value

	if orb:
		orb.connect("collected", self, "_on_orb_collected")


func _set_seeds(value: Seeds) -> void:
	seeds = value

	if seeds:
		seeds.connect("collected", self, "_on_seeds_collected")


func _on_orb_collected() -> void:
	orb = null


func _on_seeds_collected() -> void:
	seeds = null


