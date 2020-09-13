extends Spatial
class_name Map

const GRID_SIZE = Vector3(2, 2, 2)
export var size := Vector2(10, 10)

var locations := {}
var elemental : Elemental = null


func _ready() -> void:
	for z in size.y:
		for x in size.x:
			var cell = Vector3(x, 0, z)
			_add_location("Dummy", cell)


func initialize(elemental: Elemental, cell: Vector3) -> void:
	if not locations.has(cell):
		print_debug("invalid start location: ", cell)
		return

	elemental.cell = cell
	elemental.transform.origin = cell * GRID_SIZE
	self.elemental = elemental
	locations[cell].elemental = elemental


func move_elemental(direction: Vector3) -> void:
	var next_cell = elemental.cell + direction

	if not locations.has(next_cell) or not elemental.can_move():
		return

	var loc = locations[elemental.cell]
	var next_loc = locations[next_cell]
	loc.elemental = null
	elemental.cell = next_cell
	elemental.move_to(next_cell * GRID_SIZE)
	next_loc.elemental = elemental


func _add_location(alias: String, cell: Vector3) -> void:
	var terrain := Terrain.instance()
	add_child(terrain)
	terrain.initialize(Global.terrains[alias])
	terrain.transform.origin = cell * GRID_SIZE

	var loc := Location.new()
	loc.terrain = terrain
	loc.position = cell * GRID_SIZE
	loc.cell = cell

	locations[cell] = loc
