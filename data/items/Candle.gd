extends Item

var is_lit := false

onready var fire_particles := $FireParticles


func _ready() -> void:
	fire_particles.emitting = false


func _fire(boosted: bool) -> void:
	is_lit = true
	fire_particles.emitting = true


func _water(boosted: bool) -> void:
	is_lit = false
	fire_particles.emitting = false
