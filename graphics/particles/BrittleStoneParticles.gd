extends Spatial


onready var particles := $Particles


func _ready() -> void:
	particles.emitting = true
	var timer = get_tree().create_timer(1.4)
	timer.connect("timeout", self, "_timeout")


func _timeout() -> void:
	queue_free()
