extends KinematicBody2D

var velocity = Vector2()
var rotation_speed
var screen_size
var extents
var asteroid_name
var texture
signal explode

var textures = {
	'big_asteroid':'res://meteorite_1.png',
	'small_asteroid':'res://Meteorite_3.png'
}

onready var puff = get_node("puff")

func _ready():
	add_to_group("asteroids")
	randomize()
	set_physics_process(true)

	screen_size = get_viewport_rect().size

	# we initiate a random asteroid
	var index = randi() % 2
	var asteroids_list = textures.keys()
	asteroid_name = asteroids_list[index]

func init(asteroid_size, initial_spawn_pos, initial_velocity):
	asteroid_name = asteroid_size
	
	if initial_velocity.length() > 0:
		velocity = initial_velocity
	else:
		velocity = Vector2(rand_range(30, 100), 0).rotated(rand_range(0, 2*PI))
		
	rotation_speed = rand_range(-1.5, 1.5)
	
	# we set the appropriate texture, texture's scale and collision shape scale
	var scale = Vector2()
	texture = load(textures[asteroid_name])
	rescale_texture_size_and_collision_shape(asteroid_name, scale)
	
	extents = texture.get_size() / 2
	set_position(initial_spawn_pos)
	
	
func _physics_process(delta):
	set_rotation(get_rotation() + rotation_speed * delta)
	var ret = move_and_collide(velocity * delta)
	
	if ret:
		var collision_point = ret.position
		puff.set_global_position(collision_point)
		puff.set_emitting(true)
		velocity = velocity.bounce(ret.normal)
		
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
	
	
func rescale_texture_size_and_collision_shape(asteroid_name, scale):
		# according to the asteroid that we pass, we scale it different
	# e.g if we pass as small asteroid we make it smaller.
	if asteroid_name == 'small_asteroid':
		scale.x = 0.25
		scale.y = 0.25
		get_node("CollisionShape2D").set_scale(Vector2(0.6,0.6))
	else:
		scale.x = 0.5
		scale.y = 0.5
		
		# we set the texture and the scale
	get_node("Sprite").set_texture(texture)
	get_node("Sprite").set_scale(scale)
	

func explode(hit_velocity):
	emit_signal("explode", asteroid_name, get_position(), velocity, hit_velocity)
	queue_free()
	
	
	
	
	
	
	
	
	
	