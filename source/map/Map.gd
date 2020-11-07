extends Spatial
class_name Map

const GRID_SIZE = Vector3(2, 0.8, 2)

const NEIGHBORS = [
	Vector3(1, 0, 0),
	Vector3(-1, 0, 0),
	Vector3(0, 0, 1),
	Vector3(0, 0, -1)
]

signal tick()
signal finished()
signal game_over()
signal cell_hovered(cell)

var size := Vector2(0, 0)

var world := 0
var level := 0

var locations := {}
var elemental : Elemental = null

var earth_block_count := 0
var seeds_planted := 0

var optimal_steps := 0

onready var terrains := $Terrains as Node
onready var creatures := $Creatures as Node


static func instance() -> Map:
	return load("res://source/map/Map.tscn").instance() as Map


func initialize(width: int, height: int) -> void:
	size = Vector2(width, height)
	for z in size.y:
		for x in size.x:
			var cell = Vector3(x, 0, z)
			_add_location("Stone", cell, false)

	_connect_all_terrains()


func initialize_from_map_data(elemental: Elemental, map_data: MapData) -> void:
	size = Vector2(map_data.width, map_data.height)
	optimal_steps = map_data.optimal_steps

	for cell in map_data.locations.keys():
		var data : Dictionary = map_data.locations[cell]
		_add_location(data["Terrain"], cell, false)

		if data.has("Elemental"):
			place_elemental(elemental, cell)

		if data.has("Seeds"):
			add_seeds(cell)

		if data.has("Orb"):
			var alias : String = data["Orb"]
			add_orb(cell, alias)

		if data.has("Sigil"):
			var alias : String = data["Sigil"]
			add_sigil(cell, alias)

		if data.has("Creature"):
			var alias : String = data["Creature"]
			add_creature(cell, alias)

		if data.has("Obstacle"):
			var obstacle = data["Obstacle"]
			add_obstacle(cell, obstacle)

	_connect_all_terrains()


func randomize_terrain() -> void:
	for loc in locations.values():
		loc.change_terrain(Global.terrains.keys()[randi() % Global.terrains.size()])

		if randf() < 0.1:
			add_orb(loc.cell, Global.orbs.keys()[randi() % Global.orbs.size()])
		elif randf() < 0.05:
			add_sigil(loc.cell, Global.sigils.keys()[randi() % Global.sigils.size()])
		elif randf() < 0.04:
			add_seeds(loc.cell)


func tick() -> void:
	elemental.tick()

	for cell in locations:
		var loc : Location = locations[cell]
		loc.tick()

	emit_signal("tick")


func get_neighbors(loc: Location) -> Array:
	var neighbors := []

	for n_cell in NEIGHBORS:
		n_cell += loc.cell

		if not locations.has(n_cell):
			continue

		neighbors.append(locations[n_cell])

	return neighbors


func change_terrain(cell: Vector3, alias: String, elevation := 0) -> void:
	var loc : Location = locations[cell]
	loc.change_terrain(alias)


func drop_seeds() -> void:
	if not elemental.can_move() or not elemental.seeds or locations[elemental.cell].seeds:
		return

	elemental.seeds -= 1
	add_seeds(elemental.cell)


func place_elemental(elemental: Elemental, cell: Vector3) -> void:
	if not locations.has(cell):
		print_debug("invalid start location: ", cell)
		return

	var loc : Location = locations[cell]

	elemental.connect("move_finished", self, "_on_elemental_move_finished")

	elemental.cell = cell
	elemental.last_cell = cell
	elemental.transform.origin = loc.position
	elemental.visible = true

	self.elemental = elemental

	loc.character = elemental


func move_elemental(direction: Vector3) -> void:
	var next_cell = elemental.cell + direction

	if not elemental.can_move():
		return

	if not locations.has(next_cell):
		elemental.shake()
		return

	var next_loc = locations[next_cell]

	if next_loc.is_blocked(elemental.state):
		elemental.shake()
		return

	var loc = locations[elemental.cell]

	loc.character = null
	elemental.cell = next_loc.cell
	next_loc.character = elemental
	elemental.move_to(next_loc.position)


func remove_elemental() -> void:
	if not elemental:
		return

	var loc : Location = locations[elemental.cell]
	loc.character = null
	self.elemental = null


func add_creature(cell: Vector3, alias: String) -> void:
	var loc : Location = locations[cell]

	if loc.character:
		return

	if not loc.terrain:
		return

	var creature = Global.creatures[alias].instance()
	creatures.add_child(creature)

	creatures.connect("move_finished", self, "_on_creature_move_finished")

	creature.transform.origin = loc.position

	loc.character = creature


func remove_creature(cell: Vector3) -> void:
	var loc : Location = locations[cell]

	if loc.character:
		loc.character.queue_free()
		loc.character = null


func add_orb(cell: Vector3, alias: String) -> void:
	var loc : Location = locations[cell]

	if loc.orb:
		return

	if not loc.terrain:
		return

	loc.orb = Global.orbs[alias].instance()


func remove_orb(cell: Vector3) -> void:
	var loc : Location = locations[cell]
	loc.orb = null


func add_sigil(cell: Vector3, alias: String) -> void:
	var loc : Location = locations[cell]

	if loc.sigil:
		return

	if not loc.terrain:
		return

	loc.sigil = Global.sigils[alias].instance()


func remove_sigil(cell: Vector3) -> void:
	var loc : Location = locations[cell]
	loc.sigil = null


func add_seeds(cell: Vector3) -> void:
	var loc : Location = locations[cell]

	if loc.seeds:
		return

	if not loc.terrain:
		return

	loc.seeds = Seeds.instance()


func remove_seeds(cell: Vector3) -> void:
	var loc : Location = locations[cell]
	loc.seeds = null


func add_obstacle(cell: Vector3, alias: String) -> void:
	var loc : Location = locations[cell]

	if loc.obstacle:
		return

	if not loc.terrain:
		return

	loc.obstacle = Global.obstacles[alias].instance()


func remove_obstacle(cell: Vector3) -> void:
	var loc : Location = locations[cell]
	loc.obstacle = null


func get_map_data() -> MapData:
	var map_data := MapData.new()

	map_data.width = size.x
	map_data.height = size.y
	map_data.optimal_steps = optimal_steps
	map_data.world = world
	map_data.level = level

	for value in locations.values():
		var loc : Location = value

		map_data.locations[loc.cell] = {}

		map_data.locations[loc.cell]["Terrain"] = loc.terrain.alias

		if loc.orb:
			map_data.locations[loc.cell]["Orb"] = Elemental.State.keys()[loc.orb.element].to_lower().capitalize()

		if loc.sigil:
			map_data.locations[loc.cell]["Sigil"] = Elemental.State.keys()[loc.sigil.element].to_lower().capitalize()

		if loc.character:
			map_data.locations[loc.cell]["Character"] = loc.character.alias

		if loc.obstacle:
			map_data.locations[loc.cell]["Obstacle"] = loc.obstacle.alias

		if loc.seeds:
			map_data.locations[loc.cell]["Seeds"] = true

	return map_data


func _connect_all_terrains() -> void:
	for cell in locations:
		var loc : Location = locations[cell]
		for n_loc in get_neighbors(loc):
			if not loc.terrain or not n_loc.terrain:
				return

			loc.receive_from(n_loc.terrain)


func connect_entity_with(entity: Entity, loc: Location) -> void:
	loc.receive_from(entity)

	for n_loc in get_neighbors(loc):
		n_loc.receive_from(entity)


func disconnect_entity_from(entity: Entity, loc: Location) -> void:
	loc.disconnect_from(entity)

	for n_loc in get_neighbors(loc):
		n_loc.disconnect_from(entity)


func _check_conditions() -> void:
	var blocks_left = 0

	for cell in locations:
		var loc : Location = locations[cell]

		if loc.terrain.fertile:
			blocks_left += 1

	if not blocks_left:
		emit_signal("finished")


func _add_location(alias: String, cell: Vector3, animate := true) -> void:
	var terrain : Terrain = Global.terrains[alias].instance()
	var loc := Location.new()

	loc.connect("hovered", self, "_on_terrain_hovered")
	loc.connect("terrain_changed", self, "_on_terrain_changed")

	add_child(loc)

	loc.cell = cell
	loc.position = cell * GRID_SIZE
	loc.terrain = terrain

	loc.transform.origin = cell * GRID_SIZE

	locations[cell] = loc

	if animate:
		terrain.animate()


func _remove_location(cell) -> void:
	var loc : Location = locations[cell]
	loc.terrain = null
	loc.orb = null
	loc.seeds = null
	loc.obstacle = null
	locations.erase(cell)


func _move_creatures() -> void:
	for loc in locations.values():
		if not loc.character:
			continue

		_on_creature_move_finished(loc.character, loc.cell, loc.cell)


func _check_brittle_terrain(loc: Location) -> void:
	if loc.terrain.brittle:
		loc.change_terrain("None")


func _check_collecting_orb(loc: Location) -> void:
	if loc.orb:
		if [Elemental.State.ICE, Elemental.State.FIRE].has(loc.orb.element) and elemental.seeds:
			elemental.seeds = 0

		elemental.state = loc.orb.element
		elemental.plop()
		loc.orb.collect()


func _check_sigil(loc: Location) -> void:

	if loc.sigil and elemental.state == loc.sigil.element:
		return

	if loc.sigil:
		if [Elemental.State.ICE, Elemental.State.FIRE].has(loc.sigil.element) and elemental.seeds:
			elemental.seeds = 0

		elemental.state = loc.sigil.element
		elemental.plop()
		loc.sigil.activate()


func _check_collecting_seeds(loc: Location) -> void:
	if loc.seeds:
		elemental.seeds += 1
		loc.seeds.collect()


func _check_planting_seeds(loc: Location) -> void:
	if elemental.seeds and loc.terrain and loc.terrain.fertile:
		elemental.seeds -= 1
		seeds_planted += 1
		print("Seeds - 1")
		loc.change_terrain("Grass")
		SFX.play_sfx("Plant")


func _on_terrain_hovered(loc: Location) -> void:
	emit_signal("cell_hovered", loc.cell)


func _on_terrain_changed(loc: Location) -> void:
	for n_loc in get_neighbors(loc):
		if not loc.terrain or not n_loc.terrain:
			return

		loc.receive_from(n_loc.terrain)
		loc.broadcast_to(n_loc.terrain)


func _on_creature_move_finished(creature: Character, last_cell: Vector3, new_cell: Vector3) -> void:
	var last_loc: Location = locations[last_cell]
	var loc : Location = locations[new_cell]

	disconnect_entity_from(creature, last_loc)
	connect_entity_with(creature, loc)


func _on_elemental_move_finished(elemental: Character, last_cell: Vector3, new_cell: Vector3) -> void:
	var last_loc: Location = locations[last_cell]
	var loc : Location = locations[new_cell]

	disconnect_entity_from(elemental, last_loc)

	_check_collecting_orb(loc)
	_check_sigil(loc)

	connect_entity_with(elemental, loc)

	_check_brittle_terrain(last_loc)
	_check_collecting_seeds(loc)
	_check_planting_seeds(loc)

	_move_creatures()

	tick()

	call_deferred("_check_conditions")
