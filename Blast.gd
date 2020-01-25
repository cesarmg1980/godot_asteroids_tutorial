extends Area2D

var vel = Vector2()
export var speed = 1000


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


func _on_Blast_body_entered(body):
	if body.get_groups().has("asteroids"):
		queue_free()
		body.explode(vel.normalized())
