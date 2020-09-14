tool
extends HBoxContainer
class_name LabelEdit

export var alias := "" setget _set_alias
export var text := "" setget _set_text

onready var label := $Label
onready var line_edit := $LineEdit


func _ready() -> void:
	_set_alias(alias)
	_set_text(text)


func _set_alias(value: String) -> void:
	alias = value

	if label:
		label.text = value


func _set_text(value: String) -> void:
	text = value

	if line_edit:
		line_edit.text = value


func _on_LineEdit_text_changed(new_text: String) -> void:
	text = new_text
