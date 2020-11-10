extends Particles
class_name OneShotParticles

export var time := 1.4

func _ready() -> void:
	emitting = true
	var timer = get_tree().create_timer(time)
	timer.connect("timeout", self, "_timeout")


func _timeout() -> void:
	queue_free()
