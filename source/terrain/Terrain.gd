extends Spatial
class_name Terrain

var alias := ""
var cell := Vector3()
var position := Vector3()
var transitions := []


onready var mesh_instance := $MeshInstance as MeshInstance

static func instance() -> Terrain:
	return load("res://source/terrain/Terrain.tscn").instance() as Terrain


func initialize(data: TerrainData) -> void:
	alias = data.alias
	transitions = data.transitions
	mesh_instance.mesh = data.mesh
	mesh_instance.material_override = data.material
	mesh_instance.scale = Vector3(0.01, 0.01, 0.01)
