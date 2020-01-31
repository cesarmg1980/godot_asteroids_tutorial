extends Area2D

var velocity = Vector2()
export (int) var speed = 700

func _ready():
	set_process(true)
	
func start(direction ,position):
	set_position(position)
	set_rotation(direction)
	velocity = Vector2(speed, 0).rotated(get_rotation() + PI/2)

func _process(delta):
	set_position(get_position() + velocity * delta)

func _on_enemy_blast_body_entered(body):
	queue_free()

func _on_visible_screen_exited():
	queue_free()


