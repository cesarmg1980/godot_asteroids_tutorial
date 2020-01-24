extends KinematicBody2D

export var bounce = 1.1

var velocity = Vector2()
var rotation_speed
var screen_size
var extents

func _ready():
	randomize()
	set_physics_process(true)
	velocity = Vector2(rand_range(30, 100), 0).rotated(rand_range(0, 2*PI))
	rotation_speed = rand_range(-1.5, 1.5)
	screen_size = get_viewport_rect().size
	extents = get_node("Sprite").texture.get_size() / 2

func _physics_process(delta):
	set_rotation(get_rotation() + rotation_speed * delta)
	var ret = move_and_collide(velocity * delta)
	
	if ret:
		velocity += ret.normal * (ret.collider_velocity.length() * bounce)
	
	var position = get_position()
	
	if position.x > screen_size.x + extents.x:
		position.x = -extents.x
	
	if position.x < -extents.x:
		position.x = screen_size.x + extents.x
		
	if position.y > screen_size.y + extents.y:
		position.y = -extents.y
	
	if position.y < -extents.y:
		position.y = screen_size.y + extents.y
		
	set_position(position)
	
	