extends Spatial
class_name Game

export var size := Vector2(10, 10)

onready var elemental := $Elemental as Elemental
onready var map := $Map as Map
onready var camera := $OrthoCamera as OrthoCamera

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()
	if event.is_action_pressed("ui_cancel"):
		Scene.change("TitleScreen")
	if event.is_action_pressed("drop_seeds"):
		map.drop_seeds()


func _process(delta: float) -> void:
	if Input.is_action_pressed("move_left"):
		map.move_elemental(Vector3.FORWARD)
	if Input.is_action_pressed("move_down"):
		map.move_elemental(Vector3.LEFT)
	if Input.is_action_pressed("move_right"):
		map.move_elemental(Vector3.BACK)
	if Input.is_action_pressed("move_up"):
		map.move_elemental(Vector3.RIGHT)


func _ready() -> void:
	#map.initialize(20, 20)
	#map.randomize_terrain()
	#map.place_elemental(elemental, Vector3(10, 0, 10))
	map.initialize_from_map_data(elemental, Global.get_map_data())
	map.connect("finished", self, "_on_map_finished")
	camera.initialize(map.size)
	print_stray_nodes()


func _on_map_finished() -> void:
	Global.next_level()
