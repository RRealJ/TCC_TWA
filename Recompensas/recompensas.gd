extends Control

class_name Recompensa

@onready var anim = $anim


func _ready():
	get_tree().paused = true
	anim.play("entrada")
	insert()



func insert():
	var recompensas = recompesas_random()
	


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
		
		
	if 	1 in opt:
		print('1')
		
	if 2 in opt:
		load("res://Player/Armas e Bullets/area_instavel.tscn")
		r.append("res://Player/Armas e Bullets/area_instavel.tscn")
		print('2')
		
	if 3 in opt:
		load("res://Player/Armas e Bullets/bullet_normal.tscn")
		r.append("res://Player/Armas e Bullets/bullet_normal.tscn")
		print('3')
		
	if 4 in opt:
		print('4')
		
	if 5 in opt:
		print('5')

