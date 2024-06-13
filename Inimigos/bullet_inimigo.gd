extends Bullet

@onready var dano = bullet_dano


func _on_area_2d_body_entered(body):
	if menu_pausa.visible == false && recompensas_ui.visible == false:
		if body is Player:
			bullet_penetracao -= 1
			if bullet_penetracao <= 0:
				queue_free()
			body._on_hurtbox_body_entered(self) #Function no player


func _on_bullet_vida_timeout():
	queue_free()
