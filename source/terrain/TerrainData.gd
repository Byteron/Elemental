extends Resource
class_name TerrainData

export var alias := ""
export var mesh : Mesh = null
export var material : Material = null

export(Array, Resource) var transitions = []
