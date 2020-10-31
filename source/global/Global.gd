extends Node

var current_level := 0

var levels := {}

var orbs := {}
var sigils := {}
var terrains := {}
var obstacles := {}


func _ready() -> void:
	_register_scenes()
	_load_tiles()
	_load_orbs()
	_load_sigils()
	_load_obstacles()
	scan()


func scan() -> void:
	_load_levels()


func next_level() -> void:
	current_level += 1

	if levels.size() == current_level:
		current_level = 0
		Scene.change("Credits")
	else:
		Scene.change("Game")


func get_map_data() -> MapData:
	return levels.values()[current_level]


func get_map_data_from_key(key: String) -> MapData:
	return levels[key]


func _register_scenes() -> void:
	Scene.register_scene("TitleScreen", "res://source/menu/TitleScreen.tscn")
	Scene.register_scene("Game", "res://source/game/Game.tscn")
	Scene.register_scene("Editor", "res://source/editor/Editor.tscn")
	Scene.register_scene("Credits", "res://source/menu/Credits.tscn")


func _load_tiles() -> void:
	terrains.clear()

	var files = Loader.load_dir("res://data/terrains/", ["tscn"])

	for file in files:
		var terrain = file.data
		terrains[file.id] = terrain

	print(terrains)


func _load_obstacles() -> void:
	obstacles.clear()

	var files = Loader.load_dir("res://data/obstacles/", ["tscn"])

	for file in files:
		var obstacle = file.data
		obstacles[file.id] = obstacle

	print(obstacles)


func _load_orbs() -> void:
	orbs.clear()

	var files = Loader.load_dir("res://data/orbs/", ["tscn"])

	for file in files:
		var orb = file.data
		orbs[file.id] = orb

	print(orbs)


func _load_sigils() -> void:
	sigils.clear()

	var files = Loader.load_dir("res://data/sigils/", ["tscn"])

	for file in files:
		var sigil = file.data
		sigils[file.id] = sigil

	print(sigils)


func _load_levels() -> void:
	levels.clear()

	var files = Loader.load_dir("res://data/maps/", ["tres"])

	for file in files:
		var level = file.data
		levels[file.id] = level

	print(levels)
