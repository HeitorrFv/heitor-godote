extends CharacterBody2D

@export var SPEED = 175.0
@export var JUMP_FORCE = -200.0
@export var coyote_time = 0.15 
var coyote_timer = 0.0
var gravity = 980.0

var is_taking_damage = false

@onready var anim = $AnimatedSprite2D

func _physics_process(_delta):
	# 1. Gravidade e Coyote Timer
	if not is_on_floor():
		velocity.y += gravity * _delta
		coyote_timer -= _delta
	else:
		coyote_timer = coyote_time

	# 2. Lógica de Pulo (Coyote Time ativo)
	if Input.is_action_just_pressed("ui_accept") and coyote_timer > 0:
		velocity.y = JUMP_FORCE
		coyote_timer = 0.0

	# 3. Movimentação e Animações
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
		anim.play("run")
		anim.flip_h = (direction < 0)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		anim.play("idle")

	# 4. Executa o movimento
	move_and_slide()

func take_damage(enemy_pos: Vector2):
	if is_taking_damage: 
		return
		
	is_taking_damage = true
	Global.health -= 1
	
	var pos_to_check = enemy_pos if enemy_pos != Vector2.ZERO else global_position + Vector2(1, 0)
	
	var knockback_dir = (global_position - pos_to_check).normalized()
	velocity = knockback_dir * 300.0
	velocity.y = -150.0
	
	modulate.a = 0.5
	
	if Global.health <= 0:
		die()
	else:
		await get_tree().create_timer(0.5).timeout
		is_taking_damage = false
		modulate.a = 1.0

func die():
	print("Game Over - O jogador morreu!")
	Global.health = 3
	Global.coins = 0
	is_taking_damage = false
	get_tree().call_deferred("reload_current_scene")
