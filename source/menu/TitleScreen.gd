extends Control
class_name TitleScreen

onready var level_options := $VBoxContainer/HBoxContainer/LevelOptions


func _ready() -> void:
	Global.load_progress()

	Music.play_song("Song")
	Music.stop_track(1)
	Music.stop_track(2)
	Music.stop_track(3)

	yield(get_tree(), "idle_frame")

	for level in Global.levels:
		level_options.add_item(level)

	level_options.select(0)


func _on_Play_pressed() -> void:
	Global.current_level = level_options.get_item_text(level_options.get_selected_id())
	Scene.change("Game")


func _on_Editor_pressed() -> void:
	Scene.change("Editor")


func _on_Credits_pressed() -> void:
	Scene.change("Credits")


func _on_Quit_pressed() -> void:
	get_tree().quit()
