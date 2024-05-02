extends Node

class_name Mundo

@onready var player := $Player as CharacterBody2D
@onready var camera := $camera as Camera2D
@onready var label_contagem_inimigos = $"Player/player_ui/sup_direito/contagem_inimigos"
@onready var label_contagem_moedas = $"Player/player_ui/sup_direito/contagem_moedas"
@onready var moedas := 0 as int
@onready var inimigos_abatidos := 0 as int
@onready var multiplicador := Global.mundo_atual as int


func _ready():
	Global.mundo_atual = 1
	player.follow_camera(camera)


func count_moedas(moeda):
	moedas = moedas + moeda
	label_contagem_moedas.text = str(moedas)
	

func count_inimigo():
	inimigos_abatidos += 1
	label_contagem_inimigos.text = str(inimigos_abatidos)
