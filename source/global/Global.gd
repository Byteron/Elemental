extends Node

var tiles := {}

func _ready() -> void:
	_register_scenes()

	_load_tiles()


func _register_scenes():
	Scene.register_scene("TitleScreen", "res://source/menu/TitleScreen.tscn")
	Scene.register_scene("Game", "res://source/game/Game.tscn")


func _load_tiles():
	var files = Loader.load_dir("res://data/tiles/", ["tres"])

	for file in files:
		var tile = file.data
		tiles[tile.alias] = tile

	print(tiles)
