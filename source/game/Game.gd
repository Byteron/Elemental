extends Spatial
class_name Game

export var size := Vector2(10, 10)
export var random := false

var steps := 0

var behaviors := {}

var tick_calls := {}

onready var elemental := $Elemental as Elemental
onready var map := $Map as Map
onready var camera := $OrthoCamera as OrthoCamera

onready var level_label := $CanvasLayer/LevelLabel as Label
onready var step_counter_label := $CanvasLayer/StepCounterLabel as Label


func _ready() -> void:
	level_label.text = Global.current_level

	for key in Global.behaviors:
		var script : Script = Global.behaviors[key]
		var behavior : Behavior = script.new()
		behavior.map = map
		behaviors[key] = behavior

	if random:
		map.initialize(size.x, size.y)
		map.randomize_terrain()
		map.place_elemental(elemental, Vector3(size.x / 2, 0, size.y / 2))
	else:
		map.initialize_from_map_data(elemental, Global.get_map_data())

	camera.initialize(map.size)

	Music.play_element_music(Entity.Element.EARTH)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()
	if event.is_action_pressed("ui_cancel"):
		if Global.is_editor_play_mode:
			Scene.change("Editor")
		else:
			Scene.change("TitleScreen")
	if event.is_action_pressed("drop"):
		map.drop_item()


func _process(delta: float) -> void:
	yield(get_tree(), "idle_frame")
	if Input.is_action_pressed("move_left"):
		map.move_elemental(Vector3.FORWARD)
	if Input.is_action_pressed("move_down"):
		map.move_elemental(Vector3.LEFT)
	if Input.is_action_pressed("move_right"):
		map.move_elemental(Vector3.BACK)
	if Input.is_action_pressed("move_up"):
		map.move_elemental(Vector3.RIGHT)


func _finish() -> void:
	print("Rating: %f" % (float(map.optimal_steps) / float(steps) * 100.0))
	set_process(false)
	set_process_unhandled_input(false)
	elemental.finished()
	yield(get_tree().create_timer(1.5), "timeout")

	if Global.is_editor_play_mode:
		Scene.change("Editor")
	else:
		Global.next_level()


func _execute_behaviors() -> void:
	for behavior in behaviors.values():
		behavior.execute()


func _tick() -> void:
	tick_calls.clear()

	_tick_analyze()
	_tick_apply()

	steps += 1
	step_counter_label.text = "Steps: %d / %d" % [steps, map.optimal_steps]


func _tick_analyze() -> void:
	for loc in map.locations.values():
		loc.terrain.debug_color(Color.white)

	_tick_analyze_conduction()
	_tick_analyze_interactions()


func _tick_analyze_conduction() -> void:
	var conductions := _tick_get_conductions()

	for element in Entity.Element.values():
		var loc_array = conductions[element]

		for locs in loc_array:
			if _are_neighbors_broadcasting(locs, element):
				_add_broadcast_to_locations(locs, element)


func _are_neighbors_broadcasting(locs: Array, element: int) -> bool:
	for loc in locs:
		for n_loc in map.get_neighbors(loc):

			if n_loc in locs:
				continue

			if n_loc.get_broadcast().has(element):
				n_loc.terrain.debug_color(Color.red)
				return true
	return false


func _add_broadcast_to_locations(locs: Array, element: int) -> void:
	for loc in locs:
		loc.broadcast.append(element)
		loc.terrain.debug_color(Color.orange)


func _tick_get_conductions() -> Dictionary:
	var conductions := {}
	var visited := {}

	for element in Entity.Element.values():
		conductions[element] = []
		visited[element] = []

	for cell in map.locations:
		var loc: Location = map.locations[cell]

		for element in Entity.Element.values():

			if loc in visited[element]:
				continue

			var c_locs = map.find_conducting_locations(loc, element)

			if not c_locs:
				continue

			conductions[element].append(c_locs)
			visited[element] += c_locs

	return conductions


func _tick_analyze_interactions() -> void:
	for cell in map.locations:
		var loc: Location = map.locations[cell]

		if not tick_calls.has(loc):
			tick_calls[loc] = []

		for element in loc.get_broadcast():
			tick_calls[loc].append(element)

			if element == Entity.Element.FIRE:
				loc.terrain.debug_color(Color.yellow)

			for n_loc in map.get_neighbors(loc):

				if not tick_calls.has(n_loc):
					tick_calls[n_loc] = []

				if tick_calls[n_loc].has(element):
					continue

				tick_calls[n_loc].append(element)


func _tick_apply() -> void:
	for loc in tick_calls:
		var elements: Array = tick_calls[loc]

		for element in elements:
			loc.call("_" + Entity.Element.keys()[element].to_lower(), false)

		loc.broadcast.clear()


func _check_conditions() -> void:
	if _check_objectives():
		_finish()


func _check_objectives() -> bool:
	for loc in map.locations.values():
		if loc.obstacle and loc.obstacle.alias == "Fire":
			return false

		if loc.obstacle and loc.obstacle.alias == "ThunderBolt":
			return false

		if loc.character and loc.character.alias == "Fish":
			return false

		if loc.character and loc.character.alias == "Cub":
			return false
	return true


func _check_brittle_terrain(loc: Location) -> void:
	if loc.terrain.is_brittle:
		loc.change_terrain("None")


func _check_planting_seeds(loc: Location) -> void:
	if loc.terrain.alias == "Earth" and elemental.get_item_count("Seeds"):
		loc.change_terrain("Grass")
		elemental.remove_item("Seeds")


func _check_collecting_orb(loc: Location) -> void:
	if loc.orb:
		if [Entity.Element.ICE, Entity.Element.FIRE].has(loc.orb.element) and elemental.get_item_count("Seeds"):
			elemental.inventory.erase("Seeds")
			elemental.update_inventory()

		elemental.state = loc.orb.element
		elemental.plop()
		loc.orb.collect()


func _check_sigil(loc: Location) -> void:

	if loc.sigil and elemental.state == loc.sigil.element:
		return

	if loc.sigil:
		if [Entity.Element.ICE, Entity.Element.FIRE].has(loc.sigil.element) and elemental.get_item_count("Seeds"):
			elemental.inventory.erase("Seeds")
			elemental.update_inventory()

		elemental.state = loc.sigil.element
		elemental.plop()
		loc.sigil.activate()


func _check_collecting_items(loc: Location) -> void:
	if loc.item:
		elemental.add_item(loc.item.alias)
		loc.item.collect()


func _on_Map_elemental_move_finished(last_loc: Location, loc: Location) -> void:
	_check_collecting_orb(loc)
	_check_sigil(loc)

	_check_brittle_terrain(last_loc)
	_check_planting_seeds(loc)
	_check_collecting_items(loc)

	_tick()

	call_deferred("_check_conditions")


func _on_Map_creature_added(creature: Creature) -> void:
	if creature.behavior == "None":
		return

	behaviors[creature.behavior].add_creature(creature)


func _on_Map_elemental_moving() -> void:
	_execute_behaviors()
