extends Entity
class_name Elemental

enum State { WATER, EARTH, FIRE, WIND, ICE }

const SeedsMesh := preload("res://source/objects/seeds/SeedsMesh.tscn")

signal move_finished(last_cell, new_cell)

export var fire_mesh : Mesh = null
export var fire_mat : Material = null

export var water_mesh : Mesh = null
export var water_mat : Material = null

export var ice_mesh : Mesh = null
export var ice_mat : Material = null

export var earth_mesh : Mesh = null
export var earth_mat : Material = null

export var wind_mesh : Mesh = null
export var wind_mat : Material = null


export(State) var state := 1 setget _set_state

export var seeds := 0 setget _set_seeds

var last_cell := Vector3()
var cell := Vector3() setget _set_cell

onready var anim := $AnimationPlayer as AnimationPlayer
onready var tween := $Tween as Tween
onready var mesh_instance := $MeshInstance as MeshInstance
onready var seeds_container := $Seeds as Spatial

onready var wind_particles := $WindParticles/Particles
onready var ice_particles := $IceParticles/Particles
onready var fire_particles := $FireParticles/Particles
onready var water_particles := $WaterParticles/Particles
onready var smoke_particles := $SmokeParicles/Particles


func _ready() -> void:
	_set_state(state)
	mesh_instance.rotation_degrees.y = 135


func move_to(position: Vector3) -> void:
	if tween.is_active():
		return

	mesh_instance.look_at(position, Vector3.UP)

	tween.interpolate_property(self, "transform:origin", transform.origin, position, 0.28, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()


func plop() -> void:
	tween.interpolate_property(self, "scale", Vector3(1, 1, 1), Vector3(0.8, 1.2, 0.8), 0.15, Tween.TRANS_SINE, Tween.EASE_IN)
	tween.interpolate_property(self, "scale", Vector3(0.8, 1.2, 0.8), Vector3(1, 1, 1), 0.2, Tween.TRANS_BACK, Tween.EASE_OUT, 0.15)
	tween.start()


func can_move() -> bool:
	return not tween.is_active()


func shake() -> void:
	tween.interpolate_property(self, "rotation_degrees:y", rotation_degrees.y, rotation_degrees.y - 20, 0.1, Tween.TRANS_SINE, Tween.EASE_IN)
	tween.interpolate_property(self, "rotation_degrees:y", rotation_degrees.y - 20, rotation_degrees.y + 20, 0.1, Tween.TRANS_SINE, Tween.EASE_IN, 0.1)
	tween.interpolate_property(self, "rotation_degrees:y", rotation_degrees.y + 20, rotation_degrees.y, 0.1, Tween.TRANS_SINE, Tween.EASE_IN, 0.2)
	tween.start()


func finished() -> void:
	mesh_instance.rotation_degrees.y = 135
	anim.play("finished")


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


func _set_state(value: int) -> void:
	state = value

	if not wind_particles:
		return

	wind_particles.emitting = false
	ice_particles.emitting = false
	fire_particles.emitting = false
	water_particles.emitting = false
	smoke_particles.emitting = false

	var state_name : String = State.keys()[value].to_lower()

	broadcast = [ state_name ]

	mesh_instance.mesh = get(state_name + "_mesh")
	mesh_instance.material_override = get(state_name + "_mat")

	match state:
		State.FIRE:
			fire_particles.emitting = true
			smoke_particles.emitting = true
		State.ICE:
			ice_particles.emitting = true
		State.WIND:
			wind_particles.emitting = true
		State.WATER:
			water_particles.emitting = true


func _on_Tween_tween_all_completed() -> void:
	emit_signal("move_finished", last_cell, cell)
