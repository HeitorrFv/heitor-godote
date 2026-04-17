extends Area2D
func _process(delta):
	position.x -= 200 * delta # Voa infinitamente para a esquerda. Delta mantém a velocidade constante.

# Conecte o sinal body_entered da Bala
func _on_body_entered(body):
	if body.name == "Player":
		body.take_damage()
		queue_free() # A bala some ao acertar o jogador
