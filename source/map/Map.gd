extends Spatial
class_name Map

var size := Vector2(10, 10)

var tiles := {}

func _ready() -> void:
	for z in size.y:
		for x in size.x:
			var cell = Vector3(x, 0, z)
			var tile := MeshInstance.new()
			tile.scale = Vector3(0.01, 0.01, 0.01)
			tile.mesh = Global.tiles["Dummy"].mesh
			tile.transform.origin = cell * 2
			add_child(tile)
			tiles[cell] = tile
