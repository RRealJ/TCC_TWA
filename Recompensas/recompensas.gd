extends Control

class_name Recompensa

@onready var anim = $anim
@onready var slots_r: Array = $HBoxContainer.get_children()
@onready var recompensas : Array
@onready var player = $"../../../Player"


func _ready():
	visible = false
	

func upgrade():
	for s in slots_r:
		s.level_text.visible = false
	$HBoxContainer2.visible = false
	$HBoxContainer.visible = false
	visible = true
	get_tree().paused = true
	anim.play("entrada")


func insert():
	$HBoxContainer2.visible = true
	await recompesas_random()
	for i in range(0, 3):
		var temp_r = recompensas[i]
		print(temp_r)
		if recompensas[i] is PackedScene: #verificar se é uma cena
			temp_r = recompensas[i].instantiate()
			print(temp_r.item.nome)
		else:
			print(temp_r.nome)
		slots_r[i].update(temp_r) 
		temp_r = null
	$HBoxContainer.visible = true
	$HBoxContainer2/Button1.grab_focus()
	
	
func recompesas_random(): #fazer coisas aqui pra alterar e "pesar" o RNG
	var opt = []
	for i in range(0, 10):
		var rand = randi_range(1,5) #opcoes de recompensas, colocar mais buffs -> CENAS e InvItem
		if !opt.has(rand):
			opt.append(rand)
		
		if opt.size() == 3:
			print(opt)
			break
		
	if 	1 in opt: 
		var up_vida = load("res://Recompensas/upgrades e itens/up_vida.tres")
		recompensas.append(up_vida)
		print(up_vida)
		
	if 2 in opt:
		var area_instavel = load("res://Player/Armas e Bullets/area_instavel.tscn")
		print(area_instavel)
		recompensas.append(area_instavel)
		
		
	if 3 in opt:
		var bullet_normal = load("res://Player/Armas e Bullets/bullet_normal.tscn")
		recompensas.append(bullet_normal)
		print(bullet_normal)
		
	if 4 in opt:
		var up_speed = load("res://Recompensas/upgrades e itens/up_speed.tres")
		recompensas.append(up_speed)
		print(up_speed)
		
	if 5 in opt:
		var up_defesa = load("res://Recompensas/upgrades e itens/up_defense.tres")
		recompensas.append(up_defesa)
		print(up_defesa)
		
	
func esconder():
	visible = false
	get_tree().paused = false


func _on_anim_animation_finished():	
	recompensas.clear()
	insert()


func _on_button_1_pressed():
	cena(recompensas[0])
	esconder()
	

func _on_button_2_pressed():
	cena(recompensas[1])
	esconder()


func _on_button_3_pressed():
	cena(recompensas[2])
	esconder()


func cena(item):
	player.inserir(item)
