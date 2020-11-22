extends Node

var scenes := {
	"TitleScreen": "res://source/menu/TitleScreen.tscn",
	"Credits": "res://source/menu/Credits.tscn",
	"Game": "res://source/game/Game.tscn",
	"Editor": "res://source/editor/Editor.tscn",
}

func change(scene_name: String) -> void:
	if not scenes.has(scene_name):
		print("could not load %s" % scene_name)
		return

	get_tree().change_scene(scenes[scene_name])
