extends Area
class_name Elemental

signal move_finished(cell)

export var state := "Ice"
export var seeds := 0


var cell := Vector3()

onready var tween := $Tween as Tween


func move_to(position: Vector3) -> void:
	if tween.is_active():
		return

	tween.interpolate_property(self, "transform:origin", transform.origin, position, 0.28, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.start()


func can_move() -> bool:
	return not tween.is_active()


func _on_Tween_tween_all_completed() -> void:
	emit_signal("move_finished", cell)
