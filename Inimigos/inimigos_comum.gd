extends Inimigos

@onready var barra_vida = $barra_vida

func _ready():
	barra_vida.init_vida(vida)


func update_vida():
	barra_vida.value = vida
	if vida <= 0:
		morto()


func _on_hitbox_body_entered(body: Bullet):
	if body is Bullet:
		receber_dano(body.dano)
		update_vida()


