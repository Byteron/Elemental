extends Control

const CreditLabel := preload("res://source/menu/CreditsLabel.tscn")

onready var container := $VBoxContainer

onready var title := $VBoxContainer/Title
onready var names := $VBoxContainer/Names

onready var tween := $Tween

var current := 0

onready var entries := [
	{
		"Title": "Game Design",
		"Names":
		[
			"Aaron Winter (Bitron)",
			"Geoffrey Muller (ambivorous)",
			"Karlo Koščal (WingedAdventurer)"
		]
	},
	{
		"Title": "Programming",
		"Names":
		[
			"Aaron Winter (Bitron)",
		]
	},
	{
		"Title": "3D Modelling & Texturing",
		"Names":
		[
			"Emilien Rotival (LordBob)"
		]
	},
	{
		"Title": "Artworks",
		"Names":
		[
			"Geoffrey Muller (ambivorous)"
		]
	},
	{
		"Title": "Level Design",
		"Names":
		[
			"Geoffrey Muller (ambivorous)",
			"Aaron Winter (Bitron)"
		]
	},
	{
		"Title": "Sound & Music",
		"Names":
		[
			"TheMooseman",
		]
	},
	{
		"Title": "Testers",
		"Names":
		[
			"Joren Vermijs",
			"Daniel Browne",
			"Shannon Browne",
			"Alexander Zurek (Alresu)"
		]
	},
	{
		"Title": "More Testers",
		"Names":
		[
			"justadude1",
			"ColdCalzone",
			"Mat"
		]
	},
	{

		"Title": "Special Thanks",
		"Names":
		[
			"Godot Devs"
		]
	},
]

func _ready() -> void:
	animate()


func animate() -> void:
	clear()

	container.modulate.a = 0

	var entry = entries[current]

	title.text = entry["Title"]

	for author in entry["Names"]:
		var label = CreditLabel.instance()
		label.text = author
		names.add_child(label)

	tween.interpolate_property(container, "modulate:a", 0, 1, 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.interpolate_property(container, "modulate:a", 1, 0, 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 2.5)
	tween.start()


func clear() -> void:
	for child in names.get_children():
		names.remove_child(child)
		child.queue_free()


func _on_Tween_tween_all_completed() -> void:
	current = (current + 1) % entries.size()
	animate()


func _on_Back_pressed() -> void:
	Scene.change("TitleScreen", true)
