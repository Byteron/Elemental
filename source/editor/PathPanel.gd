extends PanelContainer
class_name PathPanel

signal save(index, loop)
signal remove(index)
signal path_selected(index)

onready var options := $VBoxContainer/HBoxContainer2/OptionButton
onready var loop_check_box := $VBoxContainer/HBoxContainer/CheckBox

var loop := false
var index := 0

var locs := []


func initialize(path_count: int) -> void:
	for i in options.get_item_count():
		options.remove_item(i)

	if not path_count:
		options.add_item("1")
		return

	for i in path_count:
		options.add_item(str(i + 1))


func update_path(path_entry: Dictionary) -> void:
	if locs:
		for loc in locs:
			loc.terrain.debug.visible = false

	locs = path_entry.locs

	for loc in path_entry.locs:
		loc.terrain.debug.visible = true

	loop_check_box.pressed = path_entry.loop
	_on_CheckBox_toggled(path_entry.loop)


func show() -> void:
	_on_OptionButton_item_selected(0)
	.show()


func _on_CheckBox_toggled(button_pressed: bool) -> void:
	loop = button_pressed


func _on_OptionButton_item_selected(index: int) -> void:
	self.index = index
	emit_signal("path_selected", index)


func _on_SaveButton_pressed() -> void:
	emit_signal("save", index, loop)


func _on_AddButton_pressed() -> void:
	options.add_item(str(options.get_item_count() + 1))
	options.select(options.get_item_count() - 1)
	_on_OptionButton_item_selected(options.get_item_count() - 1)


func _on_RemoveButton_pressed() -> void:
	emit_signal("remove", index)
	options.remove_item(index)
