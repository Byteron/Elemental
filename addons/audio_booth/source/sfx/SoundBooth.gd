extends Node
class_name SoundBooth

onready var sfx := {}

func _ready() -> void:

	for child in _get_children_recursive(self, []):
		sfx[child.name] = child


func play_sfx(sfx_name: String) -> void:

	if not sfx.has(sfx_name):
		print("Could not find sfx: %s" % sfx_name)
		return
	
	sfx[sfx_name].play()


func stop_sfx(sfx_name) -> void:
	if not sfx.has(sfx_name):
		print("Could not find sfx: %s" % sfx_name)
		return
	
	sfx[sfx_name].stop()


func _get_children_recursive(node: Node, children: Array) -> Array:
	for child in node.get_children():

		if child is Sound:
			children.append(child)
		else:
			_get_children_recursive(child, children)

	return children
