extends Control
class_name TitleScreen

onready var world_options := $VBoxContainer/HBoxContainer/WorldOptions
onready var level_options := $VBoxContainer/HBoxContainer/LevelOptions


func _ready() -> void:
	Global.load_progress()

	Music.play_song("Song")
	Music.stop_track(1)
	Music.stop_track(2)
	Music.stop_track(3)

	yield(get_tree(), "idle_frame")

	for world in Global.levels:
		world_options.add_item(str(world + 1))

	world_options.select(Global.current_world)
	_on_WorldOptions_item_selected(Global.current_world)

	level_options.select(Global.current_level)


func _on_Play_pressed() -> void:
	Global.current_world = world_options.get_selected_id()
	Global.current_level = level_options.get_selected_id()
	Scene.change("Game")


func _on_Editor_pressed() -> void:
	Scene.change("Editor")


func _on_Credits_pressed() -> void:
	Scene.change("Credits")


func _on_Quit_pressed() -> void:
	get_tree().quit()


func _on_WorldOptions_item_selected(index: int) -> void:
	level_options.clear()

	if not Global.levels.has(index):
		level_options.add_item("1")
		level_options.select(0)
		return

	for level in Global.levels[index]:
		level_options.add_item(str(level + 1))

	level_options.select(0)
