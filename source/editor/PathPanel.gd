extends PanelContainer
class_name PathPanel

signal save(index, loop)
signal remove(index)

onready var options := $VBoxContainer/HBoxContainer2/OptionButton

var loop := false
var index := 0

func _ready() -> void:
	options.add_item("1")


func _on_CheckBox_toggled(button_pressed: bool) -> void:
	loop = button_pressed


func _on_OptionButton_item_selected(index: int) -> void:
	self.index = index


func _on_SaveButton_pressed() -> void:
	emit_signal("save", index, loop)


func _on_AddButton_pressed() -> void:
	options.add_item(str(options.get_item_count() + 1))
	options.select(options.get_item_count() - 1)
	_on_OptionButton_item_selected(options.get_item_count() - 1)


func _on_RemoveButton_pressed() -> void:
	emit_signal("remove", index)
	options.remove_item(index)
