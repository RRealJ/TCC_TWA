extends Node

class_name Mundo


@onready var label_m_timer = $"Player/player_ui/sup_esquerda/label_timer"
@onready var player := $Player as CharacterBody2D
@onready var camera := $camera as Camera2D
@onready var label_contagem_inimigos = $"Player/player_ui/sup_direito/contagem_inimigos"
@onready var label_contagem_moedas = $"Player/player_ui/sup_direito/contagem_moedas"
@onready var moedas := 0 as int
@onready var inimigos_abatidos := 0 as int
@onready var multiplicador := Global.mundo_atual as int
@onready var counter = 0 as int
@onready var minutos = 0 as int



func _ready():
	Global.mundo_atual = 1
	player.follow_camera(camera)
#	reiniciar_levels()
	
	
func _physics_process(delta):
	label_m_timer.text = get_time()


func count_moedas(moeda):
	moedas = moedas + moeda
	label_contagem_moedas.text = str(moedas)
	

func count_inimigo():
	inimigos_abatidos += 1
	label_contagem_inimigos.text = str(inimigos_abatidos)

	
func get_time():
	if get_tree().paused == false:
		get_tree().create_timer(1).timeout
		counter += 1
		var segundos = counter/100
		minutos = minutos
		if segundos >= 60:
			segundos = 0
			counter = 0
			minutos += 1
		
		return str(minutos)+":"+str(segundos)


