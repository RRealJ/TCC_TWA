extends ProgressBar


@onready var timer = $delay_dano
@onready var barra_dano = $barra_dano


var vida = 0 : set = _set_vida


func _set_vida(nova_vida):
	var vida_anterior = vida
	vida = min(max_value, nova_vida)
	value = vida

	if vida <= 0:
		queue_free()
		
	if vida < vida_anterior:
		timer.start()
	else:
		barra_dano.value = vida
		
		
func init_vida(_vida):
	vida = _vida
	max_value = vida
	value = vida
	barra_dano.max_value = vida
	barra_dano.value = vida


func _on_delay_dano_timeout():
	barra_dano.value = vida
