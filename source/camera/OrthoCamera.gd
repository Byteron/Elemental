extends Spatial
class_name OrthoCamera

export var zoom_steps = 5.0

var max_size := 0.0
var step_size := 0.0

onready var camera := $Camera as Camera
onready var tween := $Tween as Tween


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("scroll_up"):
		camera.size = clamp(camera.size - step_size, 0, max_size)
	if event.is_action_pressed("scroll_down"):
		camera.size = clamp(camera.size + step_size, 0, max_size)
	if event.is_action_pressed("rotate_left"):
		rotate_camera(90)
	if event.is_action_pressed("rotate_right"):
		rotate_camera(-90)


func initialize(size: Vector2) -> void:
	transform.origin = Vector3.ZERO
	camera.transform.origin = Vector3.ZERO

	camera.size = max(size.x, size.y) * 1.7
	camera.transform.origin.y = size.length() / 1.5 - 1
	camera.transform.origin.z = (size.y - 1) * 2

	transform.origin = Vector3(size.x, 0, size.y) + Vector3(-1, 0, -1)
	camera.transform.origin -= transform.origin

	max_size = camera.size
	step_size = max_size / zoom_steps


func rotate_camera(degrees: float) -> void:
	if tween.is_active():
		return

	tween.interpolate_property(self, "rotation_degrees:y", rotation_degrees.y, rotation_degrees.y + degrees, 0.35, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
