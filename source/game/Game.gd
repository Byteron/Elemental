extends Spatial
class_name Game

onready var elemental := $Elemental as Elemental
onready var map := $Map as Map
onready var camera := $Camera as Camera


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left"):
		map.move_elemental(Vector3.LEFT)
	if event.is_action_pressed("ui_right"):
		map.move_elemental(Vector3.RIGHT)
	if event.is_action_pressed("ui_up"):
		map.move_elemental(Vector3.FORWARD)
	if event.is_action_pressed("ui_down"):
		map.move_elemental(Vector3.BACK)


func _ready() -> void:
	map.initialize(elemental, (Vector3(map.size.x, 0, map.size.y) / 2).floor())
	_initialize_camera()


func _initialize_camera() -> void:
	camera.size = max(map.size.x, map.size.y) * 1.7
	camera.transform.origin.y = map.size.length() / 1.5 - 1
	camera.transform.origin.z = (map.size.y - 1) * 2
