extends MusicBooth


func play_element_music(element: int) -> void:
	match element:

		Elemental.State.EARTH:
			Music.play_track(1, .5)
			Music.stop_track(2, .5)
			Music.stop_track(3, .5)
			Music.stop_track(3, .5)
			Music.stop_track(4, .5)

		Elemental.State.ICE:
			Music.play_track(2, .5)
			Music.stop_track(1, .5)
			Music.stop_track(3, .5)
			Music.stop_track(4, .5)
			Music.stop_track(5, .5)

		Elemental.State.FIRE:
			Music.play_track(3, .5)
			Music.stop_track(1, .5)
			Music.stop_track(2, .5)
			Music.stop_track(4, .5)
			Music.stop_track(5, .5)

		Elemental.State.WATER:
			Music.play_track(4, .5)
			Music.stop_track(1, .5)
			Music.stop_track(2, .5)
			Music.stop_track(3, .5)
			Music.stop_track(5, .5)

		Elemental.State.WIND:
			Music.play_track(5, .5)
			Music.stop_track(1, .5)
			Music.stop_track(2, .5)
			Music.stop_track(3, .5)
			Music.stop_track(4, .5)
