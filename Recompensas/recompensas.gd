extends Control

class_name Recompensa

@onready var anim = $anim
@onready var slots_r: Array = $HBoxContainer.get_children()
@onready var recompensas = []


func _ready():
	visible = false
	var recompensas = recompesas_random()
	

func upgrade():
	visible = true
	get_tree().paused = true
	anim.play("entrada")


func insert():
	recompensas.clear()
	recompensas = recompesas_random()
	for i in range(0, 3):
		var temp_r = recompensas[i]
		if recompensas[i] is PackedScene: #verificar se é uma cena
			temp_r = recompensas[i].instantiate() #vai instanciar a cena, sem adiciona-la no mapa
		slots_r[i].update(temp_r) 
		temp_r = null
		
	
func recompesas_random(): #fazer coisas aqui pra alterar e "pesar" o RNG
	var r = []
	var opt = []
	for i in range(0, 10):
		var rand = randi_range(1,4) #opcoes de recompensas, colocar mais buffs -> CENAS e InvItem
		if !opt.has(rand):
			opt.append(rand)
		
		if opt.size() == 3:
			print(opt)
			break
		
	if 	1 in opt: 
		var up_vida = load("res://Recompensas/upgrades e itens/up_vida.tres")
		r.append(up_vida)
		print('up_1')
		
	if 2 in opt:
		var area_instavel = load("res://Player/Armas e Bullets/area_instavel.tscn")
		r.append(area_instavel)
		print('up_2')
		
	if 3 in opt:
		var bullet_normal = load("res://Player/Armas e Bullets/bullet_normal.tscn")
		r.append(bullet_normal)
		print('up_3')
		
	if 4 in opt:
		var up_speed = load("res://Recompensas/upgrades e itens/up_speed.tres")
		r.append(up_speed)
		print('up_4')
		
	if 5 in opt:
		print('up_5')
		
	return r


func _on_anim_animation_finished():	
	insert()	
