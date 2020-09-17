extends Area
class_name Elemental

const SeedsMesh := preload("res://source/objects/seeds/SeedsMesh.tscn")

signal move_finished(last_cell, new_cell)

export var state := "Stone" setget _set_state
export var seeds := 0 setget _set_seeds

var last_cell := Vector3()
var cell := Vector3() setget _set_cell

onready var tween := $Tween as Tween
onready var mesh_instance := $MeshInstance as MeshInstance
onready var seeds_container := $Seeds as Spatial

onready var wind_particles := $WindParticles/Particles
onready var ice_particles := $IceParticles/Particles
onready var fire_particles := $FireParticles/Particles


func _ready() -> void:
	_set_state(state)


func move_to(position: Vector3) -> void:
	if tween.is_active():
		return

	tween.interpolate_property(self, "transform:origin", transform.origin, position, 0.28, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()


func can_move() -> bool:
	return not tween.is_active()


func _clear_seeds() -> void:
	for child in seeds_container.get_children():
		seeds_container.remove_child(child)
		child.queue_free()


func _add_seeds() -> void:
	_clear_seeds()

	for i in seeds:
		var spatial = Spatial.new()
		var mesh = SeedsMesh.instance()
		seeds_container.add_child(spatial)
		spatial.add_child(mesh)
		mesh.translate_object_local(Vector3.FORWARD * 1.25)
		spatial.rotation_degrees.y = (360 / seeds) * i
		print(spatial.rotation_degrees)


func _set_cell(value: Vector3) -> void:
	last_cell = cell
	cell = value


func _set_seeds(value: int) -> void:
	seeds = value
	_add_seeds()


func _set_state(value: String) -> void:
	state = value

	if not wind_particles:
		return

	wind_particles.emitting = false
	ice_particles.emitting = false
	fire_particles.emitting = false

	match state:
		"Fire": fire_particles.emitting = true
		"Ice": ice_particles.emitting = true
		"Wind": wind_particles.emitting = true


func _on_Tween_tween_all_completed() -> void:
	emit_signal("move_finished", last_cell, cell)
