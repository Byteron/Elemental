tool
extends EditorPlugin

func _enter_tree() -> void:
	add_custom_type("MusicBooth", "Node", load("addons/audio_booth/source/music/MusicBooth.gd"), load("addons/audio_booth/graphics/icons/icon.png"))
	add_custom_type("Song", "Node", load("addons/audio_booth/source/music/Song.gd"), load("addons/audio_booth/graphics/icons/icon.png"))

	add_custom_type("TrackContainer", "Node", load("addons/audio_booth/source/music/containers/TrackContainer.gd"), load("addons/audio_booth/graphics/icons/icon.png"))
	add_custom_type("StingerContainer", "Node", load("addons/audio_booth/source/music/containers/StingerContainer.gd"), load("addons/audio_booth/graphics/icons/icon.png"))

	add_custom_type("SoundBooth", "Node", load("addons/audio_booth/source/sfx/SoundBooth.gd"), load("addons/audio_booth/graphics/icons/icon.png"))
	add_custom_type("Sound", "Node", load("addons/audio_booth/source/sfx/Sound.gd"), load("addons/audio_booth/graphics/icons/icon.png"))

func _exit_tree() -> void:
	remove_custom_type("MusicBooth")
	remove_custom_type("Song")

	remove_custom_type("TrackContainer")
	remove_custom_type("StingerContainer")

	remove_custom_type("SoundBooth")
	remove_custom_type("Sound")
