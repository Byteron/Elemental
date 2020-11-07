extends Node

const SAVE_DATA_VERSION := 2
const SAVE_DATA_PATH := "user://save_data.tres"

var current_world := 0
var current_level := 0

var levels := {}

var orbs := {}
var sigils := {}
var creatures := {}
var terrains := {}
var obstacles := {}
var behaviors := {}


func _ready() -> void:
	_register_scenes()
	_load_tiles()
	_load_orbs()
	_load_sigils()
	_load_creatures()
	_load_obstacles()
	_load_behaviors()
	scan()


func scan() -> void:
	_load_levels()


func next_level() -> void:
	current_level += 1

	if current_level == levels[current_world].size():
		current_world += 1
		current_level = 0

	if current_world == levels.size():
		current_world = 0
		current_level = 0
		Scene.change("Credits")
	else:
		Scene.change("Game")
		save_progress()



func save_progress() -> void:
	var save = SaveData.new()
	save.version = SAVE_DATA_VERSION
	save.data["current_level"] = current_level
	save.data["current_world"] = current_world
	var __ = ResourceSaver.save(SAVE_DATA_PATH, save)


func load_progress() -> void:
	var save : SaveData = load(SAVE_DATA_PATH)

	if not save:
		return

	if save.version < SAVE_DATA_VERSION:
		print("warning, outdated save data!")
		return

	current_level = save.data["current_level"]
	current_world = save.data["current_world"]


func get_map_data() -> MapData:
	return levels[current_world][current_level]


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


func _load_creatures() -> void:
	creatures.clear()

	var files = Loader.load_dir("res://data/creatures/", ["tscn"])

	for file in files:
		var creature = file.data
		creatures[file.id] = creature

	print(creatures)


func _load_levels() -> void:
	levels.clear()

	var files = Loader.load_dir("res://data/maps/", ["tres"])

	for file in files:
		var level = file.data

		if not levels.has(level.world):
			levels[level.world] = {}

		levels[level.world][level.level] = level

	print(levels)


func _load_behaviors() -> void:
	behaviors.clear()

	var files = Loader.load_dir("res://data/behaviors/", ["gd"])

	for file in files:
		behaviors[file.id] = file.data

	print(behaviors)
