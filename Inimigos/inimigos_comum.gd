extends Inimigos

@onready var barra_vida = $barra_vida


func _ready():
	vida = vida
	print("Inimigo Comum: ", vida)
	barra_vida.init_vida(vida)
	barra_vida.max_value = vida


func update_vida():
	barra_vida.vida = vida
	if vida <= 0:
		morto()


func _on_hitbox_body_entered(body):
	if body.is_in_group("Bullets") or body is AreaArma:
		receber_dano(body.dano)
		update_vida()
