extends Bullet

var dano = bullet_dano * PlayerVariaveis.dano
@onready var velocidade = bullet_velocidade * PlayerVariaveis.velocidade


func _on_area_2d_body_entered(body):
	dano = bullet_dano * PlayerVariaveis.dano * item.level
	print("Normal Bullet dano: ",dano, "| level: ", item.level)
	if body is Inimigos:
		bullet_penetracao -= 1
		if bullet_penetracao <= 0:
			queue_free()
		body._on_hitbox_body_entered(self) #function no inimigo


func _on_bullet_vida_timeout():
	queue_free()
