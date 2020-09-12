tool
extends EditorPlugin

func _enter_tree() -> void:
	add_custom_type("MusicBooth", "Node", load("source/music/MusicBooth.gd"), load("graphics/icons/icon.png"))
	add_custom_type("Song", "Node", load("source/music/Song.gd"), load("graphics/icons/icon.png"))

	add_custom_type("TrackContainer", "Node", load("source/music/containers/TrackContainer.gd"), load("graphics/icons/icon.png"))
	add_custom_type("StingerContainer", "Node", load("source/music/containers/StingerContainer.gd"), load("graphics/icons/icon.png"))

	add_custom_type("SoundBooth", "Node", load("source/sfx/SoundBooth.gd"), load("graphics/icons/icon.png"))
	add_custom_type("Sound", "Node", load("source/sfx/Sound.gd"), load("graphics/icons/icon.png"))

func _exit_tree() -> void:
	remove_custom_type("MusicBooth")
	remove_custom_type("Song")

	remove_custom_type("TrackContainer")
	remove_custom_type("StingerContainer")

	remove_custom_type("SoundBooth")
	remove_custom_type("Sound")
