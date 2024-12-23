extends CharacterBody2D

class_name Inimigos

signal InimigoMorto

@export var speed_limit := 65 as int
@export var speed : int
@export var dano : int
@export var vida : int
@export var ouro:= 10 as int
@export var exp_multi:= 1 as int
@onready var target_pos : Vector2
@onready var a_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var anim_morte = preload("res://Efeitos/morte_vfx.tscn")
@onready var drop_moedas = load("res://Efeitos/drop_moedas.tscn")
@onready var drop_expe = load("res://Efeitos/drop_exp.tscn")
@onready var target = $"../../Player" #Cuidado com outros mundos, mundo_1 OK
@onready var mundo = $"../.."


func _physics_process(delta):
	if target == null:
		get_tree().get_nodes_in_group("Player")[0]
	else:
		velocity = position.direction_to(target.position) * speed
		move_and_slide()
		#if !self.is_in_group("inimigos_boss"):
		a_sprite.play("andar")
		
		if (target.position.x - position.x) < 0:
			a_sprite.flip_h = true
		else:
			a_sprite.flip_h = false
			
	target_pos = target.global_position
		
		
func receber_dano(dano_recebido):
	vida = vida - dano_recebido
	

func morto():
	await animacao_morte()
	mundo.count_inimigo()
	if self.is_in_group("inimigo_boss"):
		target.level_up()
	drop_coin()
	drop_exp()
	
	if target.vampirismo >= 1:
		var chance = randi_range(1,4)
		if chance == 1:
			var vida_apos = target.vida + 2 * target.vampirismo
			if target.vida_maxima >= vida_apos:
				target.vida = vida_apos
			else:
				target.vida = target.vida_maxima
			target.update_PlayerUI()
	
	queue_free()
	

func animacao_morte():
	var m = anim_morte.instantiate()
	m.global_position = global_position
	get_tree().get_root().add_child(m)
	
	
func drop_coin():
	var moeda = drop_moedas.instantiate()
	moeda.global_position = global_position
	moeda.valor = int(randi_range(ouro * PlayerVariaveis.sorte, ouro * 2 * PlayerVariaveis.sorte))
	mundo.add_child(moeda)
	
	
func drop_exp():
	var expee = drop_expe.instantiate()
	expee.global_position = global_position
	expee.valor = int(randi_range(5 * exp_multi, 20 * exp_multi))
	mundo.add_child(expee)
	
