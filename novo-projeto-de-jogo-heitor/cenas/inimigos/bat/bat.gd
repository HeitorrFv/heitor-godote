extends CharacterBody2D

const SPEED = 80.0
var player = null 
var can_chase = true # Controla se o morcego pode se mover e atacar

@onready var anim = $AnimatedSprite2D

func _physics_process(_delta):
	# Só se move se tiver avistado o player E não estiver no "tempo de descanso" do ataque
	if player and can_chase:
		var direction = position.direction_to(player.position)
		velocity = direction * SPEED
		
		# Vira o sprite para a direção do movimento
		if direction.x != 0:
			anim.flip_h = (direction.x < 0)
			
		move_and_slide()
	else:
		# Se não puder perseguir, ele vai parando suavemente
		velocity = velocity.move_toward(Vector2.ZERO, 5)
		move_and_slide()

# --- LÓGICA DE DETECÇÃO (Área de visão) ---

func _on_detection_zone_body_entered(body):
	if body.name == "Player":
		player = body

func _on_detection_zone_body_exited(body):
	if body.name == "Player":
		player = null

# --- LÓGICA DE ATAQUE (Hitbox) ---

func _on_hitbox_body_entered(body):
	if body.name == "Player":
		atacar_player(body)

func atacar_player(body):
	# Só ataca se o morcego não estiver em "cooldown" e o player tiver a função de dano
	if can_check_attack(body):
		body.take_damage(global_position)
		
		# Para de perseguir para não ficar "girando" no centro do player
		can_chase = false 
		
		# Tempo de espera até o próximo ataque (ajuste se quiser mais lento)
		await get_tree().create_timer(1.0).timeout 
		
		# Volta a poder perseguir
		can_chase = true 
		
		# VERIFICAÇÃO CONTÍNUA:
		# Se após 1 segundo o player ainda estiver dentro dele, ataca de novo
		var corpos_na_hitbox = $Hitbox.get_overlapping_bodies()
		for corpo in corpos_na_hitbox:
			if corpo.name == "Player":
				atacar_player(corpo)

# Função auxiliar para limpar o código do ataque
func can_check_attack(body):
	return can_chase and body.has_method("take_damage")
