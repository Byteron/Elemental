extends Control
class_name TitleScreen

onready var level := $CenterContainer/VBoxContainer/Level


func _ready() -> void:
	Music.play_song("Song")


func _on_Play_pressed() -> void:
	Global.current_level = int(level.text) - 1
	Scene.change("Game")


func _on_Editor_pressed() -> void:
	Scene.change("Editor")


func _on_Quit_pressed() -> void:
	get_tree().quit()
