extends Spatial
class_name Map

var size := Vector2(20, 20)

var tiles := {}


func _ready() -> void:
	for z in size.y:
		for x in size.x:
			var cell = Vector3(x, 0, z)
			_add_tile("Dummy", cell)


func _add_tile(alias: String, cell: Vector3) -> void:
	var tile := Tile.instance()
	add_child(tile)
	tile.initialize(Global.tiles[alias])
	tile.transform.origin = cell * 2
	tiles[cell] = tile
