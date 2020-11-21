extends Node

const SAVE_DATA_VERSION := 4
const SAVE_DATA_PATH := "user://save_data.tres"

var is_editor_play_mode := false
var editor_map_data : MapData = null

var current_level := ""

var levels := {}

var orbs := {}
var sigils := {}

var creatures := {}

var terrains := {}
var obstacles := {}
var items := {}

var behaviors := {}


func _ready() -> void:
	_register_scenes()
	_load_terrains()
	_load_orbs()
	_load_sigils()
	_load_creatures()
	_load_obstacles()
	_load_items()
	_load_behaviors()
	scan()


func scan() -> void:
	_load_levels()


func next_level() -> void:
	Scene.change("Credits")
#	current_level += 1
#
#	if current_level == levels_sorted[current_world].size():
#		current_world += 1
#		current_level = 0
#
#	if current_world == levels.size():
#		current_world = 0
#		current_level = 0
#	else:
#		Scene.change("Game")
#		save_progress()
	pass


func save_progress() -> void:
	var save = SaveData.new()
	save.version = SAVE_DATA_VERSION
	save.data["current_level"] = current_level
	var __ = ResourceSaver.save(SAVE_DATA_PATH, save)


func load_progress() -> void:
	var save : SaveData = load(SAVE_DATA_PATH)

	if not save:
		return

	if save.version < SAVE_DATA_VERSION:
		print("warning, outdated save data!")
		return

	current_level = save.data["current_level"]


func get_map_data() -> MapData:
	if is_editor_play_mode:
		return editor_map_data
	return levels[current_level]


func _register_scenes() -> void:
	Scene.register_scene("TitleScreen", "res://source/menu/TitleScreen.tscn")
	Scene.register_scene("Game", "res://source/game/Game.tscn")
	Scene.register_scene("Editor", "res://source/editor/Editor.tscn")
	Scene.register_scene("Credits", "res://source/menu/Credits.tscn")


func _load_terrains() -> void:
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


func _load_items() -> void:
	items.clear()

	var files = Loader.load_dir("res://data/items/", ["tscn"])

	for file in files:
		var item = file.data
		items[file.id] = item

	print(items)


func _load_levels() -> void:
	levels.clear()

	var files = Loader.load_dir("res://data/maps/", ["tres"])

	for file in files:
		levels[file.id] = file.data

	print(levels)


func _load_behaviors() -> void:
	behaviors.clear()

	var files = Loader.load_dir("res://data/behaviors/", ["gd"])

	for file in files:
		behaviors[file.id] = file.data

	print(behaviors)
