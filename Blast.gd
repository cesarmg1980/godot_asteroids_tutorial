extends Area2D

var vel = Vector2()
export var speed = 700


# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)


func start_at(dir, pos):
	rotation = dir
	position = pos
	vel = Vector2(speed, 0).rotated(dir - PI/2)
	

func _physics_process(delta):
	position = position + vel * delta



func _on_laser_lifetime_timeout():
	queue_free()