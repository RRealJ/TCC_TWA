extends Control

class_name Loja

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
	if $p_upgrades/set_1/upbar_vida.value >= 1:		
		PlayerVariaveis.vida = $p_upgrades/set_1/upbar_vida.value
		

func _on_up_resistencia_pressed():
	_on_button_pressed(btn_up_resistencia, $p_upgrades/set_1/upbar_resistencia)
	if $p_upgrades/set_1/upbar_resistencia.value >= 1:		
		PlayerVariaveis.resistencia = $p_upgrades/set_1/upbar_resistencia.value


func _on_up_velocidade_pressed():
	_on_button_pressed(btn_up_velocidade, $p_upgrades/set_2/upbar_velocidade)
	if $p_upgrades/set_2/upbar_velocidade.value >= 1:		
		PlayerVariaveis.velocidade = $p_upgrades/set_2/upbar_velocidade.value


func _on_up_sorte_pressed():
	_on_button_pressed($p_upgrades/set_2/up_sorte, $p_upgrades/set_2/upbar_sorte)
	if $p_upgrades/set_2/upbar_sorte.value >= 1:		
		PlayerVariaveis.sorte = $p_upgrades/set_2/upbar_sorte.value
	
	
func _on_up_dano_pressed():
	_on_button_pressed($p_upgrades/set_3/up_dano, $p_upgrades/set_3/upbar_dano)
	if $p_upgrades/set_3/upbar_dano.value >= 1:		
		PlayerVariaveis.dano = $p_upgrades/set_3/upbar_dano.value


func _on_up_chance_critica_pressed():
	_on_button_pressed(btn_up_chance_critica, $p_upgrades/set_3/upbar_chance_critica)
	if $p_upgrades/set_3/upbar_chance_critica.value >= 1:		
		PlayerVariaveis.chance_critica = $p_upgrades/set_3/upbar_chance_critica.value


func _on_voltar_menu_pressed():
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
