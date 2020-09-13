extends Spatial
class_name Map

const GRID_SIZE = Vector3(2, 2, 2)

export var size := Vector2(10, 10)

var locations := {}
var elemental : Elemental = null

onready var terrains := $Terrains
onready var objects := $Objects


func _ready() -> void:
	randomize()
	for z in size.y:
		for x in size.x:
			var cell = Vector3(x, 0, z)
			_add_location(["Earth", "Stone", "Stone", "Water"][randi() % 4], cell)


func initialize(elemental: Elemental, cell: Vector3) -> void:
	if not locations.has(cell):
		print_debug("invalid start location: ", cell)
		return

	elemental.connect("move_finished", self, "_on_elemental_move_finished")
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
	elemental.cell = next_loc.cell
	next_loc.elemental = elemental
	elemental.move_to(next_loc.position)


func _add_orb(alias: String, cell: Vector3) -> void:
	pass


func _add_seeds(cell: Vector3) -> void:
	pass


func _add_location(alias: String, cell: Vector3) -> void:
	var terrain := Terrain.instance()
	terrains.add_child(terrain)
	terrain.initialize(Global.terrains[alias])
	terrain.transform.origin = cell * GRID_SIZE

	var loc := Location.new()
	loc.terrain = terrain
	loc.position = cell * GRID_SIZE
	loc.cell = cell

	locations[cell] = loc


func _check_orb(loc: Location) -> void:
	if loc.orb:
		elemental.state = loc.orb.element
		loc.orb.queue_free()
		loc.orb = null


func _check_terrain(loc: Location) -> void:
	var terrain := ""

	for transition in loc.terrain.transitions:
		if transition.state == elemental.state:
			terrain = transition.terrain
			break

	if terrain:
		loc.terrain.queue_free()
		_add_location(terrain, loc.cell)


func _on_elemental_move_finished(cell: Vector3) -> void:
	var loc : Location = locations[cell]
	_check_orb(loc)
	_check_terrain(loc)
