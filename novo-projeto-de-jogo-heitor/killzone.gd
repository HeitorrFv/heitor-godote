extends Area2D

func _on_body_entered(body: Node2D) -> void:
	# Verificamos se quem caiu foi o Player
	if body.name == "Player":
		if body.has_method("die"):
			body.die()
