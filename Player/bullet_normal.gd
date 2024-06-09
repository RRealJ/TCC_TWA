extends Bullet


@onready var dano = bullet_dano * PlayerVariaveis.dano
@onready var velocidade = bullet_velocidade * PlayerVariaveis.velocidade


func _on_area_2d_body_entered(body):
	if body is Inimigos:
		bullet_penetracao -= 1
		if bullet_penetracao <= 0:
			queue_free()
		body._on_hitbox_body_entered(self)


func _on_bullet_vida_timeout():
	queue_free()
