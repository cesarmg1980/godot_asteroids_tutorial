extends Node

# game settings
var game_over = false
var score = 0
var level = 0

# player settings
var max_shield_level = 100
var shield_regen = 10

# asteroids settings
var break_pattern = {'big_asteroid':'small_asteroid',
						'small_asteroid':null}
						
var asteroid_damage = {'big_asteroid':20,
	'small_asteroid':10}

var asteroid_points = {'big_asteroid':10,
	'small_asteroid':20}