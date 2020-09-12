extends Spatial
class_name Elemental

var cell := Vector3()


onready var tween := $Tween as Tween


func move_to(direction: Vector3) -> void:
	if tween.is_active():
		return

	cell += direction

	tween.interpolate_property(self, "transform:origin", transform.origin, cell * 2, 0.35, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.start()
