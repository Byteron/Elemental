extends Spatial
class_name Map

export var size := Vector2(10, 10)

var locations := {}


func _ready() -> void:
	for z in size.y:
		for x in size.x:
			var cell = Vector3(x, 0, z)
			_add_location("Dummy", cell)


func _add_location(alias: String, cell: Vector3) -> void:
	var terrain := Terrain.instance()
	add_child(terrain)
	terrain.initialize(Global.terrains[alias])
	terrain.transform.origin = cell * 2

	var loc := Location.new()
	loc.terrain = terrain
	loc.position = cell * 2
	loc.cell = cell

	locations[cell] = loc
