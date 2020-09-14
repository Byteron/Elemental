extends CanvasLayer
class_name EditorHUD

enum Mode {
	TERRAIN,
	ORBS,
	SEEDS,
}


signal create_button_pressed(width, height)
signal terrain_selected(terrain)
signal orb_selected(orb)
signal elevation_selected(elevation)
signal mode_selected(mode)


onready var width_edit := $Panel/CenterContainer/VBoxContainer/HBoxContainer/VBoxContainer/Width as LabelEdit
onready var height_edit := $Panel/CenterContainer/VBoxContainer/HBoxContainer/VBoxContainer/Height as LabelEdit

onready var terrain_options := $Panel/CenterContainer/VBoxContainer/VBoxContainer/TerrainOptions as OptionButton
onready var orb_options := $Panel/CenterContainer/VBoxContainer/VBoxContainer3/OrbOptions as OptionButton

onready var orbs := $Panel/CenterContainer/VBoxContainer/VBoxContainer3
onready var terrains := $Panel/CenterContainer/VBoxContainer/VBoxContainer
onready var elevations := $Panel/CenterContainer/VBoxContainer/HBoxContainer2


func initialize() -> void:
	width_edit.text = "7"
	height_edit.text = "7"
	_on_CreateButton_pressed()
	emit_signal("terrain_selected", "Stone")
	emit_signal("elevation_selected", 0)
	emit_signal("orb_selected", "Stone")
	_on_ModeOptions_item_selected(0)


func _on_CreateButton_pressed() -> void:
	emit_signal("create_button_pressed", int(width_edit.text), int(height_edit.text))


func _on_ModeOptions_item_selected(index: int) -> void:
	match index:
		Mode.TERRAIN:
			orbs.hide()
			terrains.show()
			elevations.show()
		Mode.ORBS:
			orbs.show()
			terrains.hide()
			elevations.hide()
		Mode.SEEDS:
			orbs.hide()
			terrains.hide()
			elevations.hide()

	emit_signal("mode_selected", index)


func _on_TerrainOptions_item_selected(index: int) -> void:
	emit_signal("terrain_selected", terrain_options.get_item_text(index))


func _on_OrbOptions_item_selected(index: int) -> void:
	emit_signal("orb_selected", orb_options.get_item_text(index))


func _on_ElevationSlider_value_changed(value: float) -> void:
	emit_signal("elevation_selected", value)
