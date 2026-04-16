extends CanvasLayer

# _process roda o tempo todo, atualizando o texto visual com as variáveis do Global
func _process(delta):
	$ScoreText.text = "Moedas: " + str(Global.coins) + "\nVida: " + str(Global.health)
