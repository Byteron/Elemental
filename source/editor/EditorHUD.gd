extends CanvasLayer
class_name EditorHUD

enum Mode {
	TERRAIN,
	ORBS,
	SIGILS,
	CREATURES,
	ITEMS,
	OBSTACLES,
	ELEMENTAL
}

signal create_button_pressed(width, height)
signal save_button_pressed(world, level)
signal load_button_pressed(world, level)
signal terrain_selected(terrain)
signal orb_selected(orb)
signal sigil_selected(sigil)
signal creature_selected(creature)
signal obstacle_selected(obstacle)
signal item_selected(item)
signal elevation_selected(elevation)
signal mode_selected(mode)

var mode := 0

onready var width_edit := $LevelPanel/VBoxContainer/Create/HBoxContainer/Width as LineEdit
onready var height_edit := $LevelPanel/VBoxContainer/Create/HBoxContainer/Height as LineEdit

onready var selection_panel := $SelectionPanel as SelectionPanel

onready var mode_selection := $ModeSelection as ModeSelection

onready var world_options := $LevelPanel/VBoxContainer/SaveAndLoad2/Selection/WorldOptions
onready var level_options := $LevelPanel/VBoxContainer/SaveAndLoad2/Selection/LevelOptions


func _ready() -> void:
	mode_selection.fill(Mode.keys())

	for world in Global.levels:
		world_options.add_item(str(world + 1))

	world_options.select(0)


func initialize() -> void:
	width_edit.text = "7"
	height_edit.text = "7"

	_on_CreateButton_pressed()

	_on_ModeSelection_option_selected(0)
	_on_WorldOptions_item_selected(0)


func _on_CreateButton_pressed() -> void:
	emit_signal("create_button_pressed", int(width_edit.text), int(height_edit.text))


func _on_Save_pressed() -> void:
	emit_signal("save_button_pressed", world_options.get_selected_id(), level_options.get_selected_id())


func _on_Load_pressed() -> void:
	emit_signal("load_button_pressed", world_options.get_selected_id(), level_options.get_selected_id())


func _on_Back_pressed() -> void:
	Global.scan()
	Scene.change("TitleScreen")


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


func _on_WorldOptions_item_selected(index: int) -> void:
	level_options.clear()

	if not Global.levels.has(index):
		level_options.add_item("1")
		level_options.select(0)
		return

	for level in Global.levels[index]:
		level_options.add_item(str(level + 1))

	level_options.select(0)


func _on_AddWorldButton_pressed() -> void:
	world_options.add_item(str(world_options.get_item_count() + 1))
	world_options.select(world_options.get_item_count() - 1)
	_on_WorldOptions_item_selected(world_options.get_item_count() - 1)


func _on_AddLevelButton_pressed() -> void:
	level_options.add_item(str(level_options.get_item_count() + 1))
	level_options.select(level_options.get_item_count() - 1)


func _on_ModeSelection_option_selected(index: int) -> void:
	mode = index

	selection_panel.hide()

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

	emit_signal("mode_selected", index)
