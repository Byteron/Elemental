extends Entity
class_name Character

signal move_finished(character, last_cell, new_cell)

var last_cell := Vector3()
var cell := Vector3() setget _set_cell

onready var anim := $AnimationPlayer as AnimationPlayer
onready var tween := $Tween as Tween
onready var meshes := $Meshes as Spatial


func move_to(position: Vector3) -> void:
	if tween.is_active():
		return

	meshes.look_at(position, Vector3.UP)

	tween.interpolate_property(self, "transform:origin", transform.origin, position, 0.28, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()


func can_move() -> bool:
	return not tween.is_active()


func _set_cell(value: Vector3) -> void:
	last_cell = cell
	cell = value


func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:

	if key == ":transform:origin":
		emit_signal("move_finished", self, last_cell, cell)
