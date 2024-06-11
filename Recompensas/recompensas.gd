extends Control

class_name Recompensa

@onready var anim = $anim
@onready var slots_r: Array = $HBoxContainer.get_children()
@onready var recompensas = []


func _ready():
	get_tree().paused = true
	anim.play("entrada")


func insert():
	recompensas.clear()
	var recompensas = recompesas_random()
	for i in range(0, 3):
		var temp_r = recompensas[i]
		if recompensas[i] is PackedScene: #verificar se é uma cena
			temp_r = recompensas[i].instantiate() #vai instanciar a cena, sem adiciona-la no mapa
		slots_r[i].update(temp_r) 
		temp_r = null
		
	
func recompesas_random(): #fazer coisas aqui pra alterar e "pesar" o RNG
	var repeticao = true
	var r = []
	var opt = []
	for i in range(0, 10):
		var rand = randi_range(1,5) 
		if !opt.has(rand):
			opt.append(rand)
		
		if opt.size() == 3:
			print(opt)
			break
		
	if 	1 in opt: #colocar mais buffs e CENAS
		print('1')
		
	if 2 in opt:
		var area_instavel = load("res://Player/Armas e Bullets/area_instavel.tscn")
		r.append(area_instavel)
		print('2')
		
	if 3 in opt:
		var bullet_normal = load("res://Player/Armas e Bullets/bullet_normal.tscn")
		r.append(bullet_normal)
		print('3')
		
	if 4 in opt:
		print('4')
		
	if 5 in opt:
		print('5')
		
	return r


func _on_anim_animation_finished():	
	insert()	

