extends MusicBooth


func play_element_music(element: int) -> void:
	match element:

		Entity.Element.EARTH:
			Music.play_track(1, .5)
			Music.stop_track(2, .5)
			Music.stop_track(3, .5)
			Music.stop_track(3, .5)
			Music.stop_track(4, .5)

		Entity.Element.ICE:
			Music.play_track(2, .5)
			Music.stop_track(1, .5)
			Music.stop_track(3, .5)
			Music.stop_track(4, .5)
			Music.stop_track(5, .5)

		Entity.Element.FIRE:
			Music.play_track(3, .5)
			Music.stop_track(1, .5)
			Music.stop_track(2, .5)
			Music.stop_track(4, .5)
			Music.stop_track(5, .5)

		Entity.Element.WATER:
			Music.play_track(4, .5)
			Music.stop_track(1, .5)
			Music.stop_track(2, .5)
			Music.stop_track(3, .5)
			Music.stop_track(5, .5)

		Entity.Element.WIND:
			Music.play_track(5, .5)
			Music.stop_track(1, .5)
			Music.stop_track(2, .5)
			Music.stop_track(3, .5)
			Music.stop_track(4, .5)
