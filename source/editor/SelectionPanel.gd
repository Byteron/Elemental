extends PanelContainer
class_name SelectionPanel

signal option_selected(index)

onready var container := $GridContainer


func fill(array: Array) -> void:
	_clear()

	if not array:
		return

	for option in array:
		var button := Button.new()
		button.rect_min_size = Vector2(60, 60)
		button.text = option
		button.clip_text = true
		button.connect("pressed", self, "_on_option_selected", [ option ])
		container.add_child(button)

	_on_option_selected(array[0])


func _clear() -> void:
	hide()
	container.hide()

	for child in container.get_children():
		container.remove_child(child)
		child.queue_free()

	container.show()
	show()

func _on_option_selected(alias: String) -> void:
	emit_signal("option_selected", alias)
