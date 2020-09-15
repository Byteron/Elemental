extends Node

var current_level := 0

var terrains := {}

var levels := [
	preload("res://data/maps/01.tres"),
	preload("res://data/maps/02.tres"),
]

var orb_materials : OrbMaterialData = preload("res://data/orb_materials.tres")


func _ready() -> void:
	_register_scenes()

	_load_tiles()


func next_level() -> void:
	current_level += 1

	if levels.size() == current_level:
		Scene.change("TitleScreen")
	else:
		Scene.change("Game")


func get_map_data() -> MapData:
	return levels[current_level]


func _register_scenes() -> void:
	Scene.register_scene("TitleScreen", "res://source/menu/TitleScreen.tscn")
	Scene.register_scene("Game", "res://source/game/Game.tscn")
	Scene.register_scene("Editor", "res://source/editor/Editor.tscn")


func _load_tiles() -> void:
	var files = Loader.load_dir("res://data/terrains/", ["tscn"])

	for file in files:
		var terrain = file.data
		terrains[file.id] = terrain

	print(terrains)
