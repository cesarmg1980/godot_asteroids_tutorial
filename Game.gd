extends Node
export (PackedScene) var Asteroid
var Score


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


func new_game():
	Score = 0
	$Player.inicio($InitialPosition.position)
	$InicioTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
 

func _game_over():
	$ScoreTimer.stop()
	$AsteroidTimer.stop()
	


func _on_InicioTimer_timeout():
	$ScoreTimer.start()
	$AsteroidTimer.start()


func _on_ScoreTimer_timeout():
	Score += 1


func _on_AsteroidTimer_timeout():
	#sets an aleatory point in the screen perimeter
	$AsteroidsBoundaries/PathAsteroid.set_offset(randi())
	
	var a = Asteroid.instance()
	add_child(a)
	
	var d = $AsteroidsBoundaries/PathAsteroid.rotation
	
	a.position = $AsteroidsBoundaries/PathAsteroid.position
	
	d += rand_range(-PI/4, PI/4)
	a.rotation  = d
	a.set_linear_velocity(Vector2(rand_range(a.min_vel, a.max_vel),0).rotated(d))















