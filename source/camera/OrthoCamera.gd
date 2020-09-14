extends Camera
class_name OrthoCamera

export var zoom_steps = 5.0

var max_size := 0.0
var step_size := 0.0


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("scroll_up"):
		size = clamp(size - step_size, 0, max_size)
	if event.is_action_pressed("scroll_down"):
		size = clamp(size + step_size, 0, max_size)


func initialize(size: Vector2) -> void:
	self.size = max(size.x, size.y) * 1.7
	transform.origin.y = size.length() / 1.5 - 1
	transform.origin.z = (size.y - 1) * 2

	max_size = self.size
	step_size = max_size / zoom_steps
