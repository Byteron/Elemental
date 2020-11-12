extends TextureButton

signal selected(world, level)

export var world := 0
export var level := 0

export(Array, NodePath) var next := []


func disable() -> void:
	disabled = true
	modulate = Color.gray


func enable() -> void:
	disabled = false
	modulate = Color.white


func _on_LevelButton_pressed() -> void:
	emit_signal("selected", world, level)
