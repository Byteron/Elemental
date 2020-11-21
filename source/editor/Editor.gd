extends Spatial
class_name Editor

const MAP_PATH := "res://data/maps/"

export var Map : PackedScene = null

var current_mode := 0
var current_cell := Vector3()
var current_terrain := ""
var current_elevation := 0
var current_orb := ""
var current_sigil := ""
var current_creature := ""
var current_obstacle := ""
var current_item := ""

var current_path := []

onready var map := $Map as Map
onready var elemental := $Elemental

onready var camera := $OrthoCamera as OrthoCamera
onready var hud := $HUD


func _unhandled_input(event: InputEvent) -> void:
	match current_mode:
		EditorHUD.Mode.TERRAIN:
			_handle_terrain_mode(event)
		EditorHUD.Mode.ORBS:
			_handle_orbs_mode(event)
		EditorHUD.Mode.SIGILS:
			_handle_sigils_mode(event)
		EditorHUD.Mode.CREATURES:
			_handle_creatures_mode(event)
		EditorHUD.Mode.ITEMS:
			_handle_items_mode(event)
		EditorHUD.Mode.OBSTACLES:
			_handle_obstalces_mode(event)
		EditorHUD.Mode.ELEMENTAL:
			_handle_elemental_mode(event)
		EditorHUD.Mode.PATH:
			_handle_path_mode(event)


func _ready() -> void:
	hud.initialize()
	elemental.visible = false
	if Global.is_editor_play_mode:
		var map_data : MapData = Global.get_map_data()
		_load_map(map_data.width, map_data.height, map_data)


func _handle_terrain_mode(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		map.change_terrain(current_cell, current_terrain)
	if event.is_action_pressed("mouse_right"):
		map.change_terrain(current_cell, "None")

func _handle_orbs_mode(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		map.add_orb(current_cell, current_orb)
	if event.is_action_pressed("mouse_right"):
		map.remove_orb(current_cell)


func _handle_sigils_mode(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		map.add_sigil(current_cell, current_sigil)
	if event.is_action_pressed("mouse_right"):
		map.remove_sigil(current_cell)


func _handle_creatures_mode(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		map.add_creature(current_cell, current_creature)
	if event.is_action_pressed("mouse_right"):
		map.remove_creature(current_cell)


func _handle_obstalces_mode(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		map.add_obstacle(current_cell, current_obstacle)
	if event.is_action_pressed("mouse_right"):
		map.remove_obstacle(current_cell)


func _handle_items_mode(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		map.add_item(current_cell, current_item)
	if event.is_action_pressed("mouse_right"):
		map.remove_item(current_cell)


func _handle_elemental_mode(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		map.remove_elemental()
		map.place_elemental(elemental, current_cell)
		elemental.visible = true

	if event.is_action_pressed("mouse_right"):
		map.remove_elemental()
		elemental.visible = false


func _handle_path_mode(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		if not current_path.has(current_cell):
			add_path_cell()

	if event.is_action_pressed("mouse_right"):
		remove_path_cell()


func add_path_cell() -> void:
	current_path.append(current_cell)
	update_path()


func remove_path_cell() -> void:
	if not current_path:
		return

	var cell = current_path.pop_back()
	update_path()


func update_path() -> void:
	for loc in map.locations.values():
		loc.terrain.debug.visible = false
		loc.terrain.debug_color(Color.white)

	var i := 0
	for cell in current_path:
		var loc = map.get_location(cell)
		loc.terrain.debug.visible = true
		loc.terrain.debug_color(Color.green * (1.0 / current_path.size()) * (current_path.size() - i))
		i += 1


func _on_HUD_create_button_pressed(width: int, height: int) -> void:
	map.remove_elemental()
	map.queue_free()
	_load_map(width, height)


func _on_cell_hovered(cell: Vector3) -> void:
	current_cell = cell


func _on_HUD_terrain_selected(terrain: String) -> void:
	current_terrain = terrain
	print("Terrain Selected: ", terrain)


func _on_HUD_mode_selected(mode: int) -> void:
	current_mode = mode
	if map and current_mode != EditorHUD.Mode.PATH:
		current_path = []
		update_path()


func _on_HUD_orb_selected(orb: String) -> void:
	current_orb = orb


func _on_HUD_sigil_selected(sigil: String) -> void:
	current_sigil = sigil


func _on_HUD_creature_selected(creature: String) -> void:
	current_creature = creature


func _on_HUD_obstacle_selected(obstacle: String) -> void:
	current_obstacle = obstacle


func _on_HUD_item_selected(item: String) -> void:
	current_item = item


func _on_HUD_save_button_pressed(level: String) -> void:
	var dir = Directory.new()
	var map_data := map.get_map_data()

	var file_name := level + ".tres"
	dir.remove(MAP_PATH + file_name)
	yield(get_tree(), "idle_frame")
	ResourceSaver.save(MAP_PATH + file_name, map_data)
	Global.scan()


func _on_HUD_load_button_pressed(level: String) -> void:
	if not Global.levels.has(level):
		print("Level %s does not exist." % level)
		return

	var map_data : MapData = Global.levels[level]

	if not map_data:
		print("Level %s has no map data." % level)
		return

	map.remove_elemental()
	map.queue_free()
	_load_map(map_data.width, map_data.height, map_data)


func _load_map(width: int, height: int, map_data: MapData = null) -> void:
	map = Map.instance()
	map.connect("cell_hovered", self, "_on_cell_hovered")
	add_child(map)
	if map_data:
		map.initialize_from_map_data(elemental, map_data)
	else:
		map.initialize(width, height)
	camera.initialize(map.size)
	_initialize_paths()


func _initialize_paths() -> void:
	hud.initialize_paths(map.paths.size())

	if current_mode == EditorHUD.Mode.PATH:
		_on_HUD_path_selected(0)


func _on_HUD_save_path(index: int, loop: bool) -> void:
	map.add_path(index, current_path, loop)


func _on_HUD_remove_path(index: int) -> void:
	map.remove_path(index)


func _on_HUD_path_selected(index: int) -> void:
	var path_entry = map.get_path_entry(index)
	current_path = path_entry.path
	update_path()
	hud.update_path(path_entry)


func _on_HUD_play_button_pressed() -> void:
	Global.is_editor_play_mode = true
	Global.editor_map_data = map.get_map_data()
	Scene.change("Game")
