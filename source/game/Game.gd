extends Spatial
class_name Game

export var size := Vector2(10, 10)
export var random := false

onready var elemental := $Elemental as Elemental
onready var map := $Map as Map
onready var camera := $OrthoCamera as OrthoCamera
onready var level_label := $CanvasLayer/LevelLabel


func _ready() -> void:
	level_label.text = "Level: " + str(Global.current_level + 1)

	Music.play_track(1, 1.0)
	Music.stop_track(2, 1.0)
	Music.stop_track(3, 1.0)
	Music.stop_track(4, 1.0)
	Music.stop_track(5, 1.0)

	if random:
		map.initialize(size.x, size.y)
		map.randomize_terrain()
		map.place_elemental(elemental, Vector3(size.x / 2, 0, size.y / 2))
	else:
		map.initialize_from_map_data(elemental, Global.get_map_data())

	map.connect("finished", self, "_on_map_finished")
	camera.initialize(map.size)


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


func _on_map_finished() -> void:
	set_process(false)
	set_process_unhandled_input(false)
	elemental.finished()
	yield(get_tree().create_timer(1.5), "timeout")
	Global.next_level()
