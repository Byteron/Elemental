extends Area
class_name Elemental

const SeedsMesh := preload("res://source/objects/seeds/SeedsMesh.tscn")

signal move_finished(cell)

export var state := "Ice"
export var seeds := 0 setget _set_seeds

var cell := Vector3()

onready var tween := $Tween as Tween
onready var mesh_instance := $MeshInstance as MeshInstance
onready var seeds_container := $Seeds as Spatial


func move_to(position: Vector3) -> void:
	if tween.is_active():
		return

	tween.interpolate_property(self, "transform:origin", transform.origin, position, 0.28, Tween.TRANS_CUBIC, Tween.EASE_OUT)
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

func _set_seeds(value: int) -> void:
	seeds = value
	_add_seeds()


func _on_Tween_tween_all_completed() -> void:
	emit_signal("move_finished", cell)
