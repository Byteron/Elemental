extends CanvasLayer
class_name EditorHUD

enum Mode {
	TERRAIN,
	ORBS,
	SEEDS,
	ELEMENTAL
}


signal create_button_pressed(width, height)
signal save_button_pressed(file_name)
signal load_button_pressed(file_name)
signal terrain_selected(terrain)
signal orb_selected(orb)
signal elevation_selected(elevation)
signal mode_selected(mode)


onready var width_edit := $Panel/VBoxContainer/Create/VBoxContainer/Width as LabelEdit
onready var height_edit := $Panel/VBoxContainer/Create/VBoxContainer/Height as LabelEdit

onready var path_edit := $Panel/VBoxContainer/SaveAndLoad/PathEdit

onready var terrain_options := $Panel/VBoxContainer/Terrains/TerrainOptions as OptionButton
onready var orb_options := $Panel/VBoxContainer/Orbs/OrbOptions as OptionButton

onready var orbs := $Panel/VBoxContainer/Orbs
onready var terrains := $Panel/VBoxContainer/Terrains
onready var elevations := $Panel/VBoxContainer/Elevations


func _ready() -> void:
	for terrain in Global.terrains:
		terrain_options.add_item(terrain)

func initialize() -> void:
	width_edit.text = "7"
	height_edit.text = "7"
	_on_CreateButton_pressed()
	emit_signal("terrain_selected", terrain_options.get_item_text(0))
	emit_signal("elevation_selected", 0)
	emit_signal("orb_selected", orb_options.get_item_text(0))
	_on_ModeOptions_item_selected(0)


func _on_CreateButton_pressed() -> void:
	emit_signal("create_button_pressed", int(width_edit.text), int(height_edit.text))


func _on_ModeOptions_item_selected(index: int) -> void:
	orbs.hide()
	terrains.hide()
	elevations.hide()

	match index:
		Mode.TERRAIN:
			terrains.show()
			# elevations.show()
		Mode.ORBS:
			orbs.show()

	emit_signal("mode_selected", index)


func _on_TerrainOptions_item_selected(index: int) -> void:
	emit_signal("terrain_selected", terrain_options.get_item_text(index))


func _on_OrbOptions_item_selected(index: int) -> void:
	emit_signal("orb_selected", orb_options.get_item_text(index))


func _on_ElevationSlider_value_changed(value: float) -> void:
	emit_signal("elevation_selected", value)


func _on_Save_pressed() -> void:
	if not path_edit.text:
		return

	emit_signal("save_button_pressed", path_edit.text)


func _on_Load_pressed() -> void:
	if not path_edit.text:
		return

	emit_signal("load_button_pressed", path_edit.text)


func _on_Back_pressed() -> void:
	Scene.change("TitleScreen")
