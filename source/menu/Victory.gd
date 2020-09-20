extends Control
class_name Victory


onready var ratings := $Rating
onready var level_label := $LevelLabel


func _ready() -> void:
	level_label.text = "LEVEL %d" % Global.current_level
	Global.increase_level()
	ratings.rate(Global.sheeps, Global.max_sheeps)
	# ratings.rate(10, 10)

func _on_NextLevel_pressed() -> void:
	Global.continue_game()


func _on_Replay_pressed() -> void:
	Global.decrease_level()
	Global.continue_game()
	

func _on_Menu_pressed() -> void:
	Scene.change("TitleScreen", true)
