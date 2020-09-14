extends Spatial
class_name Game

export var size := Vector2(10, 10)

onready var elemental := $Elemental as Elemental
onready var map := $Map as Map
onready var camera := $OrthoCamera as OrthoCamera


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
	map.initialize(size.x, size.y)
	map.randomize_terrain()
	map.place_elemental(elemental, (Vector3(map.size.x, 0, map.size.y) / 2).floor())

	camera.initialize(map.size)
