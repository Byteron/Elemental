extends PanelContainer
class_name LevelPanel

signal create_button_pressed(width, height)
signal save_button_pressed(world, level)
signal load_button_pressed(world, level)

onready var width_edit := $VBoxContainer/Create/HBoxContainer/Width as LineEdit
onready var height_edit := $VBoxContainer/Create/HBoxContainer/Height as LineEdit

onready var world_options := $VBoxContainer/SaveAndLoad2/Selection/WorldOptions
onready var level_options := $VBoxContainer/SaveAndLoad2/Selection/LevelOptions


func _ready() -> void:
	for world in Global.levels:
		world_options.add_item(str(world + 1))

	world_options.select(0)


func initialize() -> void:
	width_edit.text = "7"
	height_edit.text = "7"

	_on_CreateButton_pressed()
	_on_WorldOptions_item_selected(0)


func _on_CreateButton_pressed() -> void:
	emit_signal("create_button_pressed", int(width_edit.text), int(height_edit.text))


func _on_Save_pressed() -> void:
	emit_signal("save_button_pressed", world_options.get_selected_id(), level_options.get_selected_id())


func _on_Load_pressed() -> void:
	emit_signal("load_button_pressed", world_options.get_selected_id(), level_options.get_selected_id())


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
