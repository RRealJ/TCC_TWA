extends Control

class_name Recompensa

@onready var anim = $"Control/anim"
@onready var slots_r: Array = $"Control/HBoxContainer".get_children()
@onready var recompensas : Array
@onready var player = $"../../../Player"


func _ready():
	visible = false
	$Control.visible = false
	

func upgrade():
	$alavancar.play()
	for s in slots_r:
		s.level_text.visible = false
	$"Control/HBoxContainer2".visible = false
	$"Control/HBoxContainer".visible = false
	visible = true
	$Control.visible = true
	$"..".visible = true
	get_tree().paused = true
	anim.play("entrada")


func insert():
	$"Control/HBoxContainer2".visible = true
	$recompensas_aparecerem.play()
	await recompesas_random()
	for i in range(0, 3): #nao pode ser "for r in recompensas" pq precisa do index para o slot
		var temp_r = recompensas[i]
		print(temp_r)
		if recompensas[i] is PackedScene: #verificar se é uma cena
			temp_r = recompensas[i].instantiate()
			print(temp_r.item.nome)
		else:
			print(temp_r.nome)
		slots_r[i].update(temp_r)
		temp_r = null
	$"Control/HBoxContainer".visible = true
	$"Control/HBoxContainer2/Button1".grab_focus()
	
	
func recompesas_random(): #fazer coisas aqui pra alterar e "pesar" o RNG
	var opt = []
	for i in range(0, 50):
		var rand = randi_range(1,9) #opcoes de recompensas, colocar mais buffs -> CENAS e InvItem
		if !opt.has(rand):
			opt.append(rand)
		
		if opt.size() == 3:
			break
		
	if 	1 in opt: 
		var up_vida = load("res://Recompensas/upgrades e itens/up_vida.tres")
		recompensas.append(up_vida)
	
	if 2 in opt:
		var area_instavel = load("res://Player/Armas e Bullets/area_instavel.tscn")
		recompensas.append(area_instavel)
		
	if 3 in opt:
		var bullet_normal = load("res://Player/Armas e Bullets/bullet_normal.tscn")
		recompensas.append(bullet_normal)
		
	if 4 in opt:
		var up_speed = load("res://Recompensas/upgrades e itens/up_speed.tres")
		recompensas.append(up_speed)
		
	if 5 in opt:
		var up_defesa = load("res://Recompensas/upgrades e itens/up_defense.tres")
		recompensas.append(up_defesa)
		
	if 6 in opt:
		var up_vamp = load("res://Player/itens/colar_vampirismo.tscn")
		recompensas.append(up_vamp)
		
	if 7 in opt:
		var up_sorte = load("res://Recompensas/upgrades e itens/up_sorte.tres")
		recompensas.append(up_sorte)
		
	if 8 in opt:
		var up_dano = load("res://Recompensas/upgrades e itens/up_dano.tres")
		recompensas.append(up_dano)
		
	if 9 in opt:
		var up_cc = load("res://Recompensas/upgrades e itens/up_critico.tres")
		recompensas.append(up_cc)
	
func esconder():
	visible = false
	$"..".visible = false
	$Control.visible = false
	get_tree().paused = false


func _on_anim_animation_finished():	
	recompensas.clear()
	insert()


func _on_button_1_pressed():
	cena(recompensas[0])
	

func _on_button_2_pressed():
	cena(recompensas[1])


func _on_button_3_pressed():
	cena(recompensas[2])


func cena(item):
	player.inserir(item)
	esconder()
