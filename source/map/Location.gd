extends Node
class_name Location

signal terrain_changed()

var cell := Vector3()
var position := Vector3()

var terrain : Terrain = null
var elemental : Elemental = null

var orb : Orb = null
