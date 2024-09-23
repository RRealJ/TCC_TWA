extends Node

class_name Mundo


@onready var label_m_timer = $camera/camera_ui/label_timer
@onready var player := $Player as CharacterBody2D
@onready var camera := $camera as Camera2D
@onready var label_contagem_inimigos = $"Player/player_ui/sup_direito/contagem_inimigos"
@onready var label_contagem_moedas = $"Player/player_ui/sup_direito/contagem_moedas"
@onready var moedas := 0 as int
@onready var inimigos_abatidos := 0 as int
@onready var multiplicador := Global.mundo_atual as int
@onready var counter = 0 as int
@onready var minutos = 0 as int
@onready var boss : Inimigos
@onready var mundo_bgm = $mundo_bgm


func _ready():
	player.inv.limpar()
	mundo_bgm.finished.connect(bgm_finalizado)
	mundo_bgm.play()
	label_m_timer.text = "0:0"
	Global.jogos_iniciados += 1
	player.follow_camera(camera)
	

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


func conectar_boss():
	boss.boss_morto.connect(notify_player_boss_death)


func notify_player_boss_death():
	player.salvar()
	Global.player_win = true
	player.queue_free()
	get_tree().change_scene_to_file("res://Menus/gameover.tscn")
	
	
func bgm_finalizado():
	mundo_bgm.play()


func _unhandled_input(event):
	if event.is_action_pressed("f11"):
		if Global.fullscreen == true:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			Global.fullscreen = false
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			Global.fullscreen = true
