extends Character
class_name Elemental

const SeedsMesh := preload("res://source/objects/seeds/SeedsMesh.tscn")

export(Entity.Element) var state := 1 setget _set_state

export var seeds := 0 setget _set_seeds

onready var vfx_picker := $ElementalVFXPicker

onready var mesh_instance := $Meshes/MeshInstance as MeshInstance

onready var seeds_container := $Seeds as Spatial


func _ready() -> void:
	_set_state(state)
	meshes.rotation_degrees.y = 135


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


func _set_seeds(value: int) -> void:
	seeds = value
	_add_seeds()


func _set_state(value: int) -> void:
	state = value

	vfx_picker.activate_particles(state)

	var state_name : String = Entity.Element.keys()[state].to_lower()

	broadcast = [ state ]

	mesh_instance.mesh = vfx_picker.get_mesh(state_name)
	mesh_instance.material_override = vfx_picker.get_material(state_name)


