extends Node

var terrains := {}
var orb_materials : OrbMaterialData = preload("res://data/orb_materials.tres")


func _ready() -> void:
	_register_scenes()

	_load_tiles()


func _register_scenes():
	Scene.register_scene("TitleScreen", "res://source/menu/TitleScreen.tscn")
	Scene.register_scene("Game", "res://source/game/Game.tscn")


func _load_tiles():
	var files = Loader.load_dir("res://data/terrains/", ["tres"])

	for file in files:
		var terrain = file.data
		terrains[terrain.alias] = terrain

	print(terrains)
