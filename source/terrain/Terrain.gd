extends Area
class_name Terrain

enum Action {
	MOVE,
	BLOCK,
	FALL,
}


var cell := Vector3()
var position := Vector3()

var alias := ""
var fertile := false

var transitions := []


onready var mesh_instance := $MeshInstance as MeshInstance

static func instance() -> Terrain:
	return load("res://source/terrain/Terrain.tscn").instance() as Terrain


func initialize(data: TerrainData) -> void:
	alias = data.alias
	fertile = data.fertile
	transitions = data.transitions
	mesh_instance.mesh = data.mesh
	mesh_instance.material_override = data.material
