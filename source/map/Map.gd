extends Spatial
class_name Map

const GRID_SIZE = Vector3(2, 2, 2)

signal cell_hovered(cell)

var size := Vector2(0, 0)

var locations := {}
var elemental : Elemental = null

onready var terrains := $Terrains
onready var objects := $Objects


static func instance() -> Map:
	return load("res://source/map/Map.tscn").instance() as Map


func _ready() -> void:
	pass



func initialize(width: int, height: int) -> void:
	size = Vector2(width, height)
	for z in size.y:
		for x in size.x:
			var cell = Vector3(x, 0, z)
			_add_location("Stone", cell)


func randomize_terrain() -> void:
	randomize()
	for loc in locations.values():
		_replace_terrain(loc, ["Earth", "Stone", "Stone", "Water"][randi() % 4])

		if randf() < 0.1:
			add_orb(loc.cell, ["Ice", "Stone", "Fire"][randi() % 3])
		elif randf() < 0.04:
			add_seeds(loc.cell)


func place_elemental(elemental: Elemental, cell: Vector3) -> void:
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


func change_terrain(cell: Vector3, alias: String) -> void:
	var loc : Location = locations[cell]

	_replace_terrain(loc, alias)


func add_orb(cell: Vector3, alias: String) -> void:
	var loc : Location = locations[cell]

	if loc.orb:
		return

	var orb := Orb.instance()
	objects.add_child(orb)
	orb.element = alias
	orb.mesh_instance.material_override = Global.orb_materials.get(alias.to_lower())

	loc.orb = orb


func remove_orb(cell: Vector3) -> void:
	var loc : Location = locations[cell]

	if loc.orb:
		loc.orb.queue_free()
		loc.orb = null


func add_seeds(cell: Vector3) -> void:
	var loc : Location = locations[cell]

	if loc.seeds:
		return

	var seeds := Seeds.instance()
	objects.add_child(seeds)

	loc.seeds = seeds


func remove_seeds(cell: Vector3) -> void:
	var loc : Location = locations[cell]

	if loc.seeds:
		loc.seeds.queue_free()
		loc.seeds = null

func _add_location(alias: String, cell: Vector3) -> void:
	var terrain := Terrain.instance()
	terrain.connect("mouse_entered", self, "_on_terrain_hovered", [ cell ])
	terrains.add_child(terrain)
	terrain.initialize(Global.terrains[alias])
	terrain.transform.origin = cell * GRID_SIZE

	var loc := Location.new()
	loc.terrain = terrain
	loc.position = cell * GRID_SIZE
	loc.cell = cell

	locations[cell] = loc


func _replace_terrain(loc: Location, alias: String) -> void:
	loc.terrain.queue_free()
	_add_location(alias, loc.cell)


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
		_replace_terrain(loc, terrain)

	if elemental.seeds and loc.terrain.fertile:
		elemental.seeds -= 1
		print("Seeds - 1")
		_replace_terrain(loc, "Tree")


func _on_terrain_hovered(cell: Vector3) -> void:
	emit_signal("cell_hovered", cell)


func _on_elemental_move_finished(cell: Vector3) -> void:
	var loc : Location = locations[cell]
	_check_orb(loc)
	_check_terrain(loc)
