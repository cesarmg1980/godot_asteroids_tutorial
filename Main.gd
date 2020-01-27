extends Node2D

var asteroid = preload('res://Asteroid.tscn')
var explosion = preload("res://explosion.tscn")
onready var spawn_locs = get_node("spawn_locations")
onready var asteroid_container = get_node("asteroid_container")
onready var explosion_sound = get_node("explosion_sound")
onready var back_music = get_node("back_music")
onready var HUD = get_node("HUD")
onready var player = get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	back_music.play()
	player.connect("explode", self, "explode_player")
	begin_next_level()
	
func begin_next_level():
	global.level += 1
	HUD.show_message("Level " + str(global.level))
	for i in range(global.level):
		spawn_asteroid("big_asteroid", spawn_locs.get_child(i).get_position(),
				Vector2(0,0))

func _process(delta):
	HUD.update(player)
	if asteroid_container.get_child_count() == 0:
		begin_next_level()
	
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

func explode_player():
	player.disable()
	var expl = explosion.instance()
	add_child(expl)
	expl.set_position(player.pos)
	expl.set_scale(Vector2(1.5, 1.5))
	expl.set_animation("sonic")
	expl.play()
	explosion_sound.play()
	HUD.show_message("Game Over")
	get_node("restart_timer").start()


func _on_restart_timer_timeout():
	global.new_game()
