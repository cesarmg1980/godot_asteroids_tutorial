extends Node

var game_over = false
var score = 0
var level = 0
var paused = false
var current_scene = null
var new_scene = null

# player settings
#var max_shield_level = 10
const MAX_SHIELD_LEVEL = 10
var shield_regen = 10

# asteroids settings
var break_pattern = {'big_asteroid':'small_asteroid',
						'small_asteroid':null}
						
var asteroid_damage = {'big_asteroid':20,
	'small_asteroid':10}

var asteroid_points = {'big_asteroid':10,
	'small_asteroid':20}

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1 )
	
func goto_scene(path):
	var s = ResourceLoader.load(path)
	new_scene = s.instance()
	get_tree().get_root().add_child(new_scene)
	get_tree().set_current_scene(new_scene)
	current_scene.queue_free()
	current_scene = new_scene

func new_game():
	game_over = false
	score = 0
	level = 0
	goto_scene("res://Main.tscn")


