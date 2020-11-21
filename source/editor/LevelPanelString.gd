extends PanelContainer
class_name LevelPanel

signal create_button_pressed(width, height)
signal save_button_pressed(level)
signal load_button_pressed(level)

onready var width_edit := $VBoxContainer/Create/HBoxContainer/Width as LineEdit
onready var height_edit := $VBoxContainer/Create/HBoxContainer/Height as LineEdit

onready var level_edit := $VBoxContainer/SaveAndLoad/HBoxContainer/LineEdit

onready var level_options := $VBoxContainer/SaveAndLoad/Selection/LevelOptions


func _ready() -> void:
	for level in Global.levels:
		level_options.add_item(level)

	level_options.select(0)


func initialize() -> void:
	width_edit.text = "7"
	height_edit.text = "7"

	if not Global.is_editor_play_mode:
		_on_CreateButton_pressed()


func _on_CreateButton_pressed() -> void:
	emit_signal("create_button_pressed", int(width_edit.text), int(height_edit.text))


func _on_Save_pressed() -> void:
	emit_signal("save_button_pressed", level_options.get_item_text(level_options.get_selected_id()))


func _on_Load_pressed() -> void:
	emit_signal("load_button_pressed", level_options.get_item_text(level_options.get_selected_id()))


func _on_AddLevelButton_pressed() -> void:
	level_options.add_item(level_edit.text)
	level_options.select(level_options.get_item_count() - 1)
