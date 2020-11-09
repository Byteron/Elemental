extends Spatial
class_name Sigil

export(Entity.Element) var element := 0

onready var mesh_instance := $MeshInstance as MeshInstance


func activate() -> void:
	SFX.play_element_sfx(element)
	Music.play_element_music(element)
