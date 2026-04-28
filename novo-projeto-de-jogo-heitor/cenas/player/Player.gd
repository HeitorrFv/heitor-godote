extends CharacterBody2D

@export var SPEED = 175.0 
@export var JUMP_FORCE = -200.0 
var gravity = 980.0 

# Variável para o player não levar dano seguido (0.5 segundos de paz)
var is_taking_damage = false

@onready var anim = $AnimatedSprite2D

func _physics_process(_delta):
	# 1. Aplicar Gravidade
	if not is_on_floor():
		velocity.y += gravity * _delta 

	# 2. Pular
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_FORCE

	# 3. Movimentar Esquerda/Direita
	var direction = Input.get_axis("ui_left", "ui_right")
	
	# Só permite o controle normal se não estiver no meio de um knockback pesado
	if direction: 
		velocity.x = direction * SPEED 
		anim.play("run") 
		anim.flip_h = (direction < 0) 
	else: 
		velocity.x = move_toward(velocity.x, 0, SPEED) 
		anim.play("idle") 

	move_and_slide()

# --- FUNÇÃO DE DANO COM KNOCKBACK ---
func take_damage(enemy_pos: Vector2):
	if is_taking_damage: # Se já estiver no tempo de recuperação, ignora o novo dano
		return
		
	is_taking_damage = true
	Global.health -= 1 
	
	# Lógica do Empurrão (Knockback)
	var knockback_dir = (global_position - enemy_pos).normalized()
	velocity = knockback_dir * 300.0 
	velocity.y = -150.0 
	
	# Feedback visual (transparência)
	modulate.a = 0.5 
	
	if Global.health <= 0:
		die()
	else:
		# Tempo de invulnerabilidade
		await get_tree().create_timer(0.5).timeout
		is_taking_damage = false
		modulate.a = 1.0 

# --- FUNÇÃO DE MORTE (Chamada por inimigos ou Killzone) ---
func die():
	print("Game Over - O jogador morreu!")
	
	# Resetamos as variáveis globais e locais antes de reiniciar
	Global.health = 3
	Global.coins = 0
	is_taking_damage = false # Garante que o player não renasça transparente
	
	# Reinicia a cena de forma segura (deferred)
	get_tree().call_deferred("reload_current_scene")
