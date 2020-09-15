extends Spatial
class_name Game

export var size := Vector2(10, 10)

onready var elemental := $Elemental as Elemental
onready var map := $Map as Map
onready var camera := $OrthoCamera as OrthoCamera


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		get_tree().reload_current_scene()
	if event.is_action_pressed("ui_cancel"):
		Scene.change("TitleScreen")
	if event.is_action_pressed("ui_left"):
		map.move_elemental(Vector3.LEFT)
	if event.is_action_pressed("ui_right"):
		map.move_elemental(Vector3.RIGHT)
	if event.is_action_pressed("ui_up"):
		map.move_elemental(Vector3.FORWARD)
	if event.is_action_pressed("ui_down"):
		map.move_elemental(Vector3.BACK)


func _ready() -> void:
	map.initialize_from_map_data(elemental, Global.get_map_data())
	map.connect("finished", self, "_on_map_finished")
	camera.initialize(map.size)


func _on_map_finished() -> void:
	Global.next_level()
