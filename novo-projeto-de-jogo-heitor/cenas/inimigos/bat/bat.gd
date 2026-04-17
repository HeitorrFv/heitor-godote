extends CharacterBody2D
const SPEED = 80.0
var player = null # Variável vazia. O morcego não sabe onde o player está ainda.

func _physics_process(delta):
	if player: # Se o player foi encontrado...
		# direction_to calcula a matemática do ângulo exato até o jogador!
		velocity = position.direction_to(player.position) * SPEED
		move_and_slide()

# Sinal conectado da DetectionZone (Área gigante)
func _on_detection_zone_body_entered(body):
	if body.name == "Player":
		player = body # Memoriza o corpo do player, ativando a perseguição!
