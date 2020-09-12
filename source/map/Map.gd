extends Spatial
class_name Map

export var Tile : PackedScene = null

var size := Vector2(10, 10)

var tiles := {}

func _ready() -> void:
	for z in size.y:
		for x in size.x:
			var cell = Vector3(x, 0, z)
			var tile : Spatial = Tile.instance()
			tile.transform.origin = cell * 2
			add_child(tile)
			tiles[cell] = tile
