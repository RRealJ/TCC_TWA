extends Control

@onready var btn_up_vida = $p_upgrades/set_1/up_vida
@onready var btn_up_resistencia = $p_upgrades/set_1/up_resistencia
@onready var btn_up_velocidade = $p_upgrades/set_2/up_velocidade
@onready var btn_up_chance_critica = $p_upgrades/set_3/up_chance_critica
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


func _on_button_pressed(selecao, button):
	await confirmar()
	if confirmacao.opt == 1 and button.value < 5:
		button.value += 1
	else:
		pass
	selecao.grab_focus()
	


func _on_up_vida_pressed():
	_on_button_pressed(btn_up_vida, $p_upgrades/set_1/upbar_vida)
		

func _on_up_resistencia_pressed():
	_on_button_pressed(btn_up_resistencia, $p_upgrades/set_1/upbar_resistencia)


func _on_up_velocidade_pressed():
	_on_button_pressed(btn_up_velocidade, $p_upgrades/set_2/up_velocidade)


func _on_up_sorte_pressed():
	_on_button_pressed($p_upgrades/set_2/up_sorte, $p_upgrades/set_2/upbar_sorte)
	
	
func _on_up_dano_pressed():
	_on_button_pressed($p_upgrades/set_3/up_dano, $p_upgrades/set_3/upbar_dano)


func _on_up_chance_critica_pressed():
	_on_button_pressed(btn_up_chance_critica, $p_upgrades/set_3/upbar_chance_critica)
