extends Spatial
class_name Game

export var size := Vector2(10, 10)
export var random := false

var behaviors := {}

var steps := 0

onready var elemental := $Elemental as Elemental
onready var map := $Map as Map
onready var camera := $OrthoCamera as OrthoCamera

onready var level_label := $CanvasLayer/LevelLabel as Label
onready var step_counter_label := $CanvasLayer/StepCounterLabel as Label


func _ready() -> void:
	level_label.text = "%d - %d" % [Global.current_world + 1, Global.current_level + 1]

	for key in Global.behaviors:
		var script : Script = Global.behaviors[key]
		var behavior : Behavior = script.new()
		behavior.map = map
		behaviors[key] = behavior

	if random:
		map.initialize(size.x, size.y)
		map.randomize_terrain()
		map.place_elemental(elemental, Vector3(size.x / 2, 0, size.y / 2))
	else:
		map.initialize_from_map_data(elemental, Global.get_map_data())

	camera.initialize(map.size)

	Music.play_element_music(Elemental.State.EARTH)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()
	if event.is_action_pressed("ui_cancel"):
		Scene.change("TitleScreen")
	if event.is_action_pressed("drop_seeds"):
		map.drop_seeds()


func _process(delta: float) -> void:
	yield(get_tree(), "idle_frame")
	if Input.is_action_pressed("move_left"):
		move_elemental(Vector3.FORWARD)
	if Input.is_action_pressed("move_down"):
		move_elemental(Vector3.LEFT)
	if Input.is_action_pressed("move_right"):
		move_elemental(Vector3.BACK)
	if Input.is_action_pressed("move_up"):
		move_elemental(Vector3.RIGHT)


func move_elemental(direction: Vector3) -> void:
	map.move_elemental(direction)


func execute_behaviors() -> void:
	for behavior in behaviors.values():
		behavior.execute()


func _on_Map_creature_added(creature: Creature) -> void:
	behaviors[creature.behavior].add_creature(creature)


func _on_Map_pretick() -> void:
	execute_behaviors()


func _on_Map_finished() -> void:
	print("Rating: %f" % (float(map.optimal_steps) / float(steps) * 100.0))
	set_process(false)
	set_process_unhandled_input(false)
	elemental.finished()
	yield(get_tree().create_timer(1.5), "timeout")
	Global.next_level()


func _on_Map_tick() -> void:
	steps += 1
	step_counter_label.text = "Steps: %d / %d" % [steps, map.optimal_steps]
