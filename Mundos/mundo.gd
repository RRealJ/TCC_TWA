extends Node

class_name Mundo

var start_level_msec = 0
@onready var label_m_timer = $"Player/player_ui/sup_esquerda/label_timer"
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
	var start_level_msec = Time.get_ticks_msec()
	
	
func _physics_process(delta):
	label_m_timer.text = get_time()

func count_moedas(moeda):
	moedas = moedas + moeda
	label_contagem_moedas.text = str(moedas)
	

func count_inimigo():
	inimigos_abatidos += 1
	label_contagem_inimigos.text = str(inimigos_abatidos)

	
func get_time():
	var level_time = Time.get_ticks_msec() - start_level_msec
	var minutos = level_time/1000/60
	var segundos = level_time/1000%60
	#var msec = level_time%1000/100 ->> caso precise utilizar milisegundos
	return str(minutos)+":"+str(segundos)#+":"+str(msec)
