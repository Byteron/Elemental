extends Spatial
class_name Game

onready var elemental := $Elemental as Elemental
onready var map := $Map as Map
onready var camera := $Camera as Camera


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left"):
		elemental.move_to(transform.origin + Vector3.LEFT)
	if event.is_action_pressed("ui_right"):
		elemental.move_to(transform.origin + Vector3.RIGHT)
	if event.is_action_pressed("ui_up"):
		elemental.move_to(transform.origin + Vector3.FORWARD)
	if event.is_action_pressed("ui_down"):
		elemental.move_to(transform.origin + Vector3.BACK)


func _ready() -> void:
	elemental.move_to(Vector3(map.size.x, 0, map.size.y) / 2)
	camera.size = max(map.size.x, map.size.y) * 1.7
	camera.transform.origin.y = map.size.length() / 1.5 - 1
	camera.transform.origin.z = (map.size.y - 1) * 2
