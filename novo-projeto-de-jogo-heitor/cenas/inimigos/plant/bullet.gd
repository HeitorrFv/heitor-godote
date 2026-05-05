extends Area2D

@export var speed = 200

func _process(delta):
	position.x += speed * delta 

func _on_body_entered(body):
	# Agora ele vai reconhecer o nó 'Player' que está na sua lista
	if body.name == "Player":
		if body.has_method("take_damage"):
			body.take_damage(global_position) 
		queue_free() 
	elif body is StaticBody2D or body is TileMap:
		queue_free()
