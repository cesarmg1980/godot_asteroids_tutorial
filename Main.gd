extends Node2D

var asteroid = preload('res://Asteroid.tscn')
var explosion = preload("res://explosion.tscn")
onready var spawn_locs = get_node("spawn_locations")
onready var asteroid_container = get_node("asteroid_container")
onready var explosion_sound = get_node("explosion_sound")
onready var back_music = get_node("back_music")


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	for i in range(4):
		spawn_asteroid("big_asteroid", spawn_locs.get_child(i).get_position(),
						Vector2(0,0))
	back_music.play()
	

func _process(delta):
	get_node("HUD/shield_bar").set_value(get_node("Player").shield_level)
	if asteroid_container.get_child_count() == 0:
		for i in range(8):
			spawn_asteroid("big_asteroid", spawn_locs.get_child(i).get_position(),
						Vector2(0,0))

func spawn_asteroid(size, position, velocity):
		var ast = asteroid.instance()
		ast.init(size, position, velocity)
		asteroid_container.add_child(ast)
		ast.connect("explode", self, "explode_asteroid")
		

func explode_asteroid(size, pos, vel, hit_vel):
	var newsize = global.break_pattern[size]
	if newsize:
		for offset in [-1, 1]:
			var newpos = pos + hit_vel.tangent().clamped(25) * offset
			var newvel = vel + hit_vel.tangent() * offset
			spawn_asteroid(newsize, newpos, newvel)
	var expl = explosion.instance()
	add_child(expl)
	expl.set_position(pos)
	expl.play()		
	explosion_sound.play()
			
			
			
			