extends CharacterBody2D

class_name Inimigos

signal InimigoMorto

@export var speed_limit := 65 as int
@export var speed = 60
@export var dano = 10
@export var vida = 30
@export var ouro:= 10 as int
@export var exp: int
@onready var anim_morte = preload("res://Efeitos/morte_vfx.tscn")
@onready var drop_moedas = load("res://drop_moedas.tscn")
@onready var target = $"../../Player" #Cuidado com outros mundos, mundo_1 OK
@onready var mundo = $"../.."


func _physics_process(delta):
	if target == null:
		get_tree().get_nodes_in_group("Player")[0]
	else:
		velocity = position.direction_to(target.position) * speed
		move_and_slide()
		
		
func receber_dano(dano_recebido):
	vida = vida - dano_recebido
	

func morto():
	await animacao_morte()
	mundo.count_inimigo()
	drop_coin()
	drop_exp()
	queue_free()
	

func animacao_morte():
	var morto = anim_morte.instantiate()
	morto.global_position = global_position
	get_tree().get_root().add_child(morto)
	
	
func drop_coin():
	var moeda = drop_moedas.instantiate()
	moeda.global_position = global_position
	moeda.valor = int(randi_range(5 * PlayerVariaveis.sorte, 20 * PlayerVariaveis.sorte))
	mundo.add_child(moeda)
	
	
func drop_exp():
	pass
	



