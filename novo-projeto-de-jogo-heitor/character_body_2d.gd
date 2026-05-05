extends CharacterBody2D

# Certifique-se de arrastar o Bullet.tscn para este campo no Inspetor
@export var bullet_scene: PackedScene

func _on_timer_timeout():
	if bullet_scene:
		# Cria a instância da bala
		var bullet = bullet_scene.instantiate()
		
		# Define a posição global correta
		bullet.global_position = global_position
		
		# Adiciona a bala à cena (na raiz da fase)
		get_parent().add_child(bullet)
