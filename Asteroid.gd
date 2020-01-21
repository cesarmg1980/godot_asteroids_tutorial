extends KinematicBody2D

var vel = Vector2()
var rot_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	set_physics_process(true)
	vel = Vector2(rand_range(30,100),0).rotated(rand_range(0, 2*PI))
	rot_speed = rand_range(-1.5, 1.5)

func _physics_process(delta):
	rotation = rotation + rot_speed * delta
	move_and_collide(vel * delta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
