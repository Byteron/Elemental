extends CanvasLayer
class_name EditorHUD

enum Mode {
	TERRAIN,
	ORBS,
	SIGILS,
	SEEDS,
	OBSTACLES,
	ELEMENTAL
}


signal create_button_pressed(width, height)
signal save_button_pressed(file_name)
signal load_button_pressed(file_name)
signal terrain_selected(terrain)
signal orb_selected(orb)
signal sigil_selected(sigil)
signal obstacle_selected(obstacle)
signal elevation_selected(elevation)
signal mode_selected(mode)


onready var width_edit := $Panel/VBoxContainer/Create/VBoxContainer/Width as LabelEdit
onready var height_edit := $Panel/VBoxContainer/Create/VBoxContainer/Height as LabelEdit

onready var path_edit := $Panel/VBoxContainer/SaveAndLoad/PathEdit

onready var mode_options := $Panel/VBoxContainer/Mode/ModeOptions as OptionButton
onready var terrain_options := $Panel/VBoxContainer/Terrains/TerrainOptions as OptionButton
onready var orb_options := $Panel/VBoxContainer/Orbs/OrbOptions as OptionButton
onready var sigil_options := $Panel/VBoxContainer/Sigils/SigilOptions as OptionButton
onready var obstacle_options := $Panel/VBoxContainer/Obstacles/ObstacleOptions as OptionButton

onready var orbs := $Panel/VBoxContainer/Orbs
onready var sigils := $Panel/VBoxContainer/Sigils
onready var obstacles := $Panel/VBoxContainer/Obstacles
onready var terrains := $Panel/VBoxContainer/Terrains
onready var elevations := $Panel/VBoxContainer/Elevations


func _ready() -> void:
	for mode in Mode.keys():
		mode_options.add_item(mode)

	for terrain in Global.terrains:
		terrain_options.add_item(terrain)

	for obstacle in Global.obstacles:
		obstacle_options.add_item(obstacle)

	for orb in Global.orbs:
		orb_options.add_item(orb)

	for sigil in Global.sigils:
		sigil_options.add_item(sigil)


func initialize() -> void:
	width_edit.text = "7"
	height_edit.text = "7"
	_on_CreateButton_pressed()
	emit_signal("terrain_selected", terrain_options.get_item_text(0))
	emit_signal("elevation_selected", 0)
	emit_signal("orb_selected", orb_options.get_item_text(0))
	emit_signal("sigil_selected", orb_options.get_item_text(0))
	emit_signal("obstacle_selected", obstacle_options.get_item_text(0))
	_on_ModeOptions_item_selected(0)


func _on_CreateButton_pressed() -> void:
	emit_signal("create_button_pressed", int(width_edit.text), int(height_edit.text))


func _on_ModeOptions_item_selected(index: int) -> void:
	orbs.hide()
	sigils.hide()
	obstacles.hide()
	terrains.hide()
	elevations.hide()

	match index:
		Mode.TERRAIN:
			terrains.show()
			# elevations.show()
		Mode.ORBS:
			orbs.show()
		Mode.SIGILS:
			sigils.show()
		Mode.OBSTACLES:
			obstacles.show()

	emit_signal("mode_selected", index)


func _on_TerrainOptions_item_selected(index: int) -> void:
	emit_signal("terrain_selected", terrain_options.get_item_text(index))


func _on_OrbOptions_item_selected(index: int) -> void:
	emit_signal("orb_selected", orb_options.get_item_text(index))


func _on_SigilOptions_item_selected(index: int) -> void:
	emit_signal("sigil_selected", sigil_options.get_item_text(index))


func _on_ObstacleOptions_item_selected(index: int) -> void:
	emit_signal("obstacle_selected", orb_options.get_item_text(index))


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
	Global.scan()
	Scene.change("TitleScreen")
