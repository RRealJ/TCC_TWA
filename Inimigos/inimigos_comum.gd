extends Inimigos

@onready var vida_i = vida
@onready var barra_vida = $barra_vida

func _ready():
	barra_vida.init_vida(vida_i)


func update_vida():
	barra_vida.value = vida_i
	print('update vida')
	if vida_i <= 0:
		queue_free()


func _on_hitbox_body_entered(body: Bullet):
	print('entrou body')
	if body is Bullet:
		print('entrou bullet')
		receber_dano(body.dano)
		update_vida()

	

