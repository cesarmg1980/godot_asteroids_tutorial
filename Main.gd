extends Node2D

var asteroid = preload('res://Asteroid.tscn')
onready var spawn_locs = get_node("spawn_locations")
onready var asteroid_container = get_node("asteroid_container")

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(5):
		var ast = asteroid.instance()
		asteroid_container.add_child(ast)
		ast.init("big_asteroid", spawn_locs.get_child(i).get_position())
