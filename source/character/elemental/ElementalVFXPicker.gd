extends Spatial
class_name ElementalVFXPicker

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

export var thunder_mesh : Mesh = null
export var thunder_mat : Material = null

export var light_mesh : Mesh = null
export var light_mat : Material = null

export var dark_mesh : Mesh = null
export var dark_mat : Material = null

onready var wind_particles := $WindParticles as Particles
onready var ice_particles := $IceParticles as Particles
onready var fire_particles := $FireParticles as Particles
onready var water_particles := $WaterParticles as Particles
onready var smoke_particles := $SmokeParicles as Particles


func activate_particles(state: int) -> void:
	if not wind_particles:
		return

	wind_particles.emitting = false
	ice_particles.emitting = false
	fire_particles.emitting = false
	water_particles.emitting = false
	smoke_particles.emitting = false

	match state:
		Elemental.State.FIRE:
			fire_particles.emitting = true
			smoke_particles.emitting = true
		Elemental.State.ICE:
			ice_particles.emitting = true
		Elemental.State.WIND:
			wind_particles.emitting = true
		Elemental.State.WATER:
			water_particles.emitting = true


func get_material(state_name: String) -> Material:
	return get(state_name + "_mat")


func get_mesh(state_name: String) -> Mesh:
	return get(state_name + "_mesh")
