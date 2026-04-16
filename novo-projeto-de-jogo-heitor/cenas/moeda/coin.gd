extends Area2D

# ATENÇÃO: Essa função não funciona sozinha! Ela precisa ser conectada via Sinal (próximo slide).
func _on_body_entered(body):
	if body.name == "Player": # Verifica se quem tocou na moeda foi o jogador
		Global.coins += 1     # Aumenta a pontuação no nosso script Global
		queue_free()          # queue_free destrói o objeto (faz a moeda sumir da tela)
