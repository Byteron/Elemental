extends Button

onready var pointer := $Pointer
onready var tween := $Tween


func _on_MenuButton_mouse_entered() -> void:
	SFX.play_sfx("GrabSeeds")
	tween.interpolate_property(pointer, "rect_size:y", 0, rect_size.y, 0.5, Tween.TRANS_BACK, Tween.EASE_OUT)
	tween.start()


func _pressed() -> void:
	SFX.play_sfx("Plant")


func _on_MenuButton_mouse_exited() -> void:
	tween.stop_all()
	pointer.rect_size.y = 0
