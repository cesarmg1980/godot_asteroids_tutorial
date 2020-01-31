extends Area2D

var bullet = preload("res://enemy_blast.tscn")
onready var paths = get_node("enemy_paths")
onready var bullet_container = get_node("bullet_container")
onready var shoot_timer = get_node("shoot_timer")

var path
var follow
var remotenode
var speed = 250

var target = null

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	randomize()
	path = paths.get_children()[randi() % paths.get_child_count()]
	follow = PathFollow2D.new()
	path.add_child(follow)
	follow.set_loop(false)
	remotenode = Node2D.new()
	follow.add_child(remotenode)
	get_node("enemy_animation").set_current_animation("rotation")
	shoot_timer.set_wait_time(0.6) # will vary by level
	shoot_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	follow.set_offset(follow.get_offset() + speed * delta)
	set_position(remotenode.get_global_position())
	if follow.get_unit_offset() > 1:
		queue_free()


func _on_shoot_timer_timeout():
	shoot_1()

func shoot_1():
	var dir = target.global_position - global_position
	var b = bullet.instance()
	bullet_container.add_child(b)
	b.start(dir.angle(), global_position)
	