extends Spatial
class_name Tile

var alias := ""
var position := Vector3()
var cell := Vector3()

onready var mesh_instance := $MeshInstance as MeshInstance

static func instance() -> Tile:
	return load("res://source/tile/Tile.tscn").instance() as Tile


func initialize(data: TileData) -> void:
	alias = data.alias
	mesh_instance.mesh = data.mesh
	mesh_instance.scale = Vector3(0.01, 0.01, 0.01)
