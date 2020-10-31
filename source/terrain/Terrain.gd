extends Entity
class_name Terrain

signal hovered()
signal change(alias)

export var height := 0.0
export var speed := 0.0

export var alias := ""
export var fertile := false
export var brittle := false

var cell := Vector3()
var position := Vector3()

onready var anim := $AnimationPlayer as AnimationPlayer
onready var tween := $Tween as Tween


func _ready() -> void:
	rotation_degrees.y = [0, 90, 180, 270][randi() % 4]
	var timer = get_tree().create_timer(randf())
	timer.connect("timeout", self, "_timeout")


func change(alias: String) -> void:
	call_deferred("emit_signal", "change", alias)


func animate() -> void:
	anim.play("spawn")
	SFX.play_sfx("Grow")


func destroy() -> void:
	_destroy()


func is_blocked(state: int) -> bool:
	return _is_blocked(state)


func _set_height(value: float) -> void:
	height = value
	transform.origin.y = value


func _destroy() -> void:
	queue_free()


func _is_blocked(state: int) -> bool:
	return true


func _timeout() -> void:
	tween.interpolate_property(self, "transform:origin:y", transform.origin.y, transform.origin.y - height, speed / 2, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.interpolate_property(self, "transform:origin:y", transform.origin.y - height,transform.origin.y, speed / 2, Tween.TRANS_SINE, Tween.EASE_IN_OUT, speed / 2)
	tween.start()


func _on_Area_mouse_entered() -> void:
	emit_signal("hovered")
