extends PanelContainer
class_name ModeSelection

var BUTTON_GROUP := ButtonGroup.new()

signal option_selected(index)

onready var container := $Container


func fill(array: Array) -> void:
	_clear()

	if not array:
		return

	var index := 0
	for option in array:
		option = option.to_lower().capitalize()
		var button := Button.new()
		button.group = BUTTON_GROUP
		button.toggle_mode = true
		button.rect_min_size = Vector2(80, 38)
		button.text = option
		button.clip_text = true
		button.connect("pressed", self, "_on_option_selected", [ index ])
		container.add_child(button)
		index += 1

	container.get_child(0).pressed = true
	_on_option_selected(0)


func _clear() -> void:
	hide()
	container.hide()

	for child in container.get_children():
		container.remove_child(child)
		child.queue_free()

	container.show()
	show()

func _on_option_selected(index: int) -> void:
	emit_signal("option_selected", index)


