extends AnimatedSprite




func _on_explosion_sprite_animation_finished():
	queue_free()
