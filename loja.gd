extends Control

@onready var btn_up_vida = $p_upgrades/set_1/up_vida
@onready var upbar_vida = $p_upgrades/set_1/upbar_vida
@onready var upbar_resistencia = $p_upgrades/set_1/upbar_resistencia
@onready var upbar_velocidade = $p_upgrades/set_2/upbar_velocidade
@onready var upbar_sorte = $p_upgrades/set_2/upbar_sorte
@onready var upbar_dano = $p_upgrades/set_3/upbar_dano
@onready var upbar_chance_critica = $p_upgrades/set_3/upbar_chance_critica
@onready var confirmacao = $confirmacao


func _ready():
	btn_up_vida.grab_focus()


func mostrar(mostrar):
	mostrar.show()	
	
	
func confirmar():
	mostrar(confirmacao)
	$"confirmacao/HBoxContainer/sim".grab_focus()
	await confirmacao.decidido
	confirmacao.hide()

	
func _on_up_vida_pressed():
	await confirmar()
	btn_up_vida.grab_focus()
	if confirmacao.opt == 1 and upbar_vida.value < 5:
		upbar_vida.value += 1
	else:
		pass	
		
