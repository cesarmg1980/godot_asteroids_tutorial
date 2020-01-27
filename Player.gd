extends Area2D

signal explode
export var rot_speed = 2.6
export var thrust = 500
export var max_vel = 400
export var friction = 0.65
export (PackedScene) var bullet
onready var laser_container = get_node("laser_container")
onready var fire_rate_timer = get_node("fire_rate_timer")
onready var shoot_sound = get_node("shoot_sound")

var screen_size = Vector2()
var rot = 0
var pos = Vector2()
var vel = Vector2()
var acc = Vector2()
var shield_level = global.MAX_SHIELD_LEVEL
var shield_up = true

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	pos = Vector2(screen_size.x / 2, screen_size.y /2)
	set_position(pos)
	set_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shield_up:
		shield_level = min(shield_level + global.shield_regen * delta, global.MAX_SHIELD_LEVEL)
		if shield_level <= 0 and shield_level:
			shield_up = false
			shield_level = 0
			get_node("shield").hide()

	if Input.is_action_pressed("ui_accept"):
		if fire_rate_timer.time_left == 0:
			shoot()
	if Input.is_action_pressed("ui_left"):
		rot -= rot_speed * delta
	if Input.is_action_pressed("ui_right"):
		rot += rot_speed * delta
	if Input.is_action_pressed("ui_up"):
		acc = Vector2(thrust,0).rotated(rot)
		get_node("exhaust").show()
	else:
		acc = Vector2(0,0)
		get_node("exhaust").hide()
	
	acc += vel * -friction
	vel += acc * delta
	pos += vel * delta
	
	if pos.x > screen_size.x:
		pos.x = 0
	if pos.x < 0:
		pos.x = screen_size.x
	if pos.y > screen_size.y:
		pos.y = 0
	if pos.y < 0:
		pos.y = screen_size.y
	
	set_position(pos)
	set_rotation(rot + PI / 2)
	
func shoot():
	fire_rate_timer.start()
	var lb = bullet.instance()
	laser_container.add_child(lb)
	lb.start_at(rotation, get_node("muzzle").global_position) 
	shoot_sound.play()

func disable():
	hide()
	call_deferred("set_process", false)
	call_deferred("set_monitoring", false)

func _on_Player_body_entered(body):
	if body.get_groups().has("asteroids"):
		if shield_up:
			body.explode(vel)
			shield_level -= global.asteroid_damage[body.asteroid_size]
		else:
			emit_signal("explode")
