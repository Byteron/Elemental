extends Spatial
class_name Editor

var current_mode := 0
var current_cell := Vector3()
var current_terrain := ""
var current_elevation := 0
var current_orb := ""

onready var map := $Map as Map
onready var camera := $OrthoCamera as OrthoCamera
onready var hud := $HUD

func _unhandled_input(event: InputEvent) -> void:
	match current_mode:
		EditorHUD.Mode.TERRAIN:
			_handle_terrain_mode(event)
		EditorHUD.Mode.ORBS:
			_handle_orbs_mode(event)
		EditorHUD.Mode.SEEDS:
			_handle_seeds_mode(event)


func _ready() -> void:
	hud.initialize()


func _handle_terrain_mode(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		map.change_terrain(current_cell, current_terrain, current_elevation)


func _handle_orbs_mode(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		map.add_orb(current_cell, current_orb)
	if event.is_action_pressed("mouse_right"):
		map.remove_orb(current_cell)


func _handle_seeds_mode(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		map.add_seeds(current_cell)
	if event.is_action_pressed("mouse_right"):
		map.remove_seeds(current_cell)


func _on_HUD_create_button_pressed(width: int, height: int) -> void:
	map.queue_free()
	map = Map.instance()
	map.connect("cell_hovered", self, "_on_cell_hovered")
	add_child(map)
	map.initialize(width, height)
	camera.initialize(map.size)


func _on_cell_hovered(cell: Vector3) -> void:
	current_cell = cell


func _on_HUD_terrain_selected(terrain: String) -> void:
	current_terrain = terrain
	print("Terrain Selected: ", terrain)


func _on_HUD_mode_selected(mode: int) -> void:
	current_mode = mode


func _on_HUD_orb_selected(orb: String) -> void:
	current_orb = orb
	print("Orb Selected: ", orb)


func _on_HUD_elevation_selected(elevation: int) -> void:
	current_elevation = elevation
	print("Current Elevation: ", elevation)
