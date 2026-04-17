extends CharacterBody2D
var dir = 1 # Começa andando para a direita (1). Esquerda seria -1.

func _physics_process(delta):
	# Adicione gravidade aqui também igual ao player (velocity.y += gravity * delta) se quiser!
	velocity.x = dir * 50
	move_and_slide()
	
	# Se o laser (RayCast2D) bater em alguma coisa...
	if $WallCheck.is_colliding():
		dir *= -1 # Inverte a direção (1 vira -1, -1 vira 1)
		scale.x *= -1 # Inverte a imagem e o laser para o outro lado!

func _on_hitbox_player_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
