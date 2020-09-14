extends Control
class_name TitleScreen


func _on_Play_pressed() -> void:
	Scene.change("Game")


func _on_Editor_pressed() -> void:
	Scene.change("Editor")


func _on_Quit_pressed() -> void:
	get_tree().quit()
