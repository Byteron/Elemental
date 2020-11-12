extends Control

onready var level_container := $Levels

func _ready() -> void:
	Global.current_world = 0
	Global.current_level = 6

	for level in level_container.get_children():
		level.connect("selected", self, "_on_level_selected")
		level.disable()

	for level in level_container.get_children():

		if level.world <= Global.current_world and level.level <= Global.current_level:
			level.enable()

		if level.world <= Global.current_world and level.level < Global.current_level:
			for next_level_path in level.next:
				var next_level = level.get_node(next_level_path)
				next_level.enable()

	update()


func make_id(world: int, level: int) -> int:
	return world * 100 + level


func _draw() -> void:
	print("draw")

	for level in level_container.get_children():
		for next_level_path in level.next:
			var next_level = level.get_node(next_level_path)
			print("draw_line", level.level, " -> ", next_level.level)
			if next_level.disabled:
				draw_line(level.rect_position + level.rect_size / 2, next_level.rect_position + level.rect_size / 2, Color.gray, 10)
			else:
				draw_line(level.rect_position + level.rect_size / 2, next_level.rect_position + level.rect_size / 2, Color.white, 10)


func _on_level_selected(world: int, level: int) -> void:
	Global.current_world = world
	Global.current_level = level
	Scene.change("Game")
