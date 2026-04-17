extends CharacterBody2D

# @export cria um campo lá no Inspector. Arraste o arquivo Bullet.tscn do FileSystem para este campo!
@export var bullet_scene: PackedScene

func _on_timer_timeout():
	# instantiate() cria um clone (uma cópia viva) da cena da bala.
	var bullet = bullet_scene.instantiate()
	bullet.position = position # A bala nasce no mesmo lugar da planta
	get_parent().add_child(bullet) # Coloca a bala na Fase para ela existir de verdade
