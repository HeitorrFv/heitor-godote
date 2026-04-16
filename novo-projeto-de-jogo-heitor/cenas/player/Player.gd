extends CharacterBody2D

@export var SPEED = 175.0 # Velocidade de movimento lateral
@export var JUMP_FORCE = -200.0 # Força do pulo (Lembre-se: Negativo vai para CIMA)
var gravity = 980.0 # Força da gravidade (Positivo puxa para BAIXO)

# Pega a referência da nossa animação para podermos controlá-la
@onready var anim = $AnimatedSprite2D

# A função _physics_process roda 60 vezes por segundo (é o coração da física)
func _physics_process(delta):
	# 1. Aplicar Gravidade se não estiver no chão (is_on_floor verifica o TileMap)
	if not is_on_floor():
		velocity.y += gravity * delta # Delta ajusta a queda para ser suave em qualquer PC

	# 2. Pular se apertar a tecla Espaço/Seta para Cima (ui_accept) e estiver no chão
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_FORCE

	# 3. Movimentar Esquerda/Direita
	# get_axis retorna -1 (Esquerda), 1 (Direita) ou 0 (Parado)
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction: # Se o jogador estiver apertando algum botão de andar...
		velocity.x = direction * SPEED # Aplica a velocidade
		anim.play("run") # Toca a animação "run"
		anim.flip_h = (direction < 0) # Vira a imagem para a esquerda se direction for negativo
	else: # Se soltou os botões...
		velocity.x = move_toward(velocity.x, 0, SPEED) # Freia o personagem
		anim.play("idle") # Toca a animação "idle"

	# Aplica todas as velocidades configuradas acima e faz o personagem realmente se mover!
	move_and_slide()
