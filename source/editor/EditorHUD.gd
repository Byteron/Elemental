extends CanvasLayer
class_name EditorHUD

enum Mode {
	ELEMENTAL
	TERRAIN,
	ORBS,
	SIGILS,
	ITEMS,
	OBSTACLES,
	CREATURES,
	PATH
}

signal play_button_pressed()

signal mode_selected(mode)

signal save_path(index, loop)
signal remove_path(index)
signal path_selected(index)

signal create_button_pressed(width, height)
signal save_button_pressed(level)
signal load_button_pressed(level)

signal terrain_selected(terrain)
signal orb_selected(orb)
signal sigil_selected(sigil)
signal creature_selected(creature)
signal obstacle_selected(obstacle)
signal item_selected(item)


var mode := 0

onready var mode_selection := $ModeSelection as ModeSelection
onready var selection_panel := $SelectionPanel as SelectionPanel

onready var level_panel := $LevelPanelString as LevelPanel


onready var path_panel := $PathPanel as PathPanel


func _ready() -> void:
	mode_selection.fill(Mode.keys())


func initialize() -> void:
	level_panel.initialize()

	_on_ModeSelection_option_selected(0)


func update_path(path_entry: Dictionary) -> void:
	path_panel.update_path(path_entry)


func initialize_paths(path_count: int) -> void:
	path_panel.initialize(path_count)


func _on_Back_pressed() -> void:
	Global.scan()
	Scene.change("TitleScreen")
	Global.is_editor_play_mode = false


func _on_SelectionPanel_option_selected(alias: String) -> void:
	match mode:
		Mode.TERRAIN:
			emit_signal("terrain_selected", alias)
		Mode.ORBS:
			emit_signal("orb_selected", alias)
		Mode.SIGILS:
			emit_signal("sigil_selected", alias)
		Mode.CREATURES:
			emit_signal("creature_selected", alias)
		Mode.OBSTACLES:
			emit_signal("obstacle_selected", alias)
		Mode.ITEMS:
			emit_signal("item_selected", alias)


func _on_ModeSelection_option_selected(index: int) -> void:
	mode = index

	selection_panel.hide()
	path_panel.hide()

	match index:
		Mode.TERRAIN:
			selection_panel.fill(Global.terrains.keys())
		Mode.ORBS:
			selection_panel.fill(Global.orbs.keys())
		Mode.SIGILS:
			selection_panel.fill(Global.sigils.keys())
		Mode.CREATURES:
			selection_panel.fill(Global.creatures.keys())
		Mode.OBSTACLES:
			selection_panel.fill(Global.obstacles.keys())
		Mode.ITEMS:
			selection_panel.fill(Global.items.keys())
		Mode.PATH:
			path_panel.show()

	emit_signal("mode_selected", index)


func _on_PathPanel_save(index: int, loop: bool) -> void:
	emit_signal("save_path", index, loop)


func _on_PathPanel_remove(index: int) -> void:
	emit_signal("remove_path", index)


func _on_PathPanel_path_selected(index: int) -> void:
	emit_signal("path_selected", index)


func _on_Play_pressed() -> void:
	emit_signal("play_button_pressed")


func _on_LevelPanelString_create_button_pressed(width: int, height: int) -> void:
	emit_signal("create_button_pressed", width, height)


func _on_LevelPanelString_load_button_pressed(level: String) -> void:
	emit_signal("load_button_pressed", level)


func _on_LevelPanelString_save_button_pressed(level: String) -> void:
	emit_signal("save_button_pressed", level)
