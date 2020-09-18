extends Terrain


export var particles : PackedScene = null


func _destroy() -> void:
	print("destroy")
	var p : Spatial = particles.instance()
	get_tree().current_scene.add_child(p)
	p.transform.origin = transform.origin
	queue_free()


func _on_moved(map) -> void:
	pass


func _is_blocked(state: String) -> bool:
	return false
