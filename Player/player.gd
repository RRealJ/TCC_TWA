extends CharacterBody2D

class_name Player

signal PlayerDeath

const iFrame_duration = 1.5
@export var max_speed = 75 * PlayerVariaveis.velocidade
@export var ACELERACAO = 500 * PlayerVariaveis.velocidade
@export var FRICCAO = 1000 * PlayerVariaveis.velocidade
@onready var axis = Vector2.ZERO
@onready var texto_vida = $player_ui/sup_esquerda/texto_barra_vida
@onready var texto_velocidade = $player_ui/inf_direita/texto_velocidade
@onready var remote_transform := $remote as RemoteTransform2D
@onready var gameover = $"../gameover"
@onready var barra_vida = $player_ui/sup_esquerda/barra_vida
@onready var mini_barra = $mini_barra
@onready var anim_sprite = $anim
@onready var anim = $animation
@onready var animationTree = $AnimationTree
@onready var state_machine = animationTree["parameters/playback"]
@onready var anim_morte = preload("res://Efeitos/morte_vfx.tscn")
@onready var mundo = $".."
@onready var barra_exp = $"player_ui/inferior/barra_exp"
@onready var exp := 0 as int
@onready var nivel := 1 as int
@onready var texto_nivel = $"player_ui/inf_esquerda/texto_nivel"

var vida_maxima = 100 + 25 * PlayerVariaveis.vida
var vida = vida_maxima
var speed = max_speed
var aceleracao = ACELERACAO
var friccao = FRICCAO
enum{IDLE, MOVE}
var state = IDLE

var blend_pos: Vector2 = Vector2.ZERO
var blend_pos_paths = [
	"parameters/idle/idle_bs2d/blend_position",
	"parameters/move/move_bs2D/blend_position"
]

var animTree_state_keys = [
	"idle",
	"move"
]

func _ready():
	barra_exp.min_value = 0
	barra_exp.max_value = 100
	barra_exp.value = 0
	$player_ui/sup_direito/contagem_inimigos.text = "0"
	$player_ui/sup_direito/contagem_moedas.text = "0"
	barra_vida.init_vida(vida)
	mini_barra.init_vida(vida)
	update_PlayerUI()


func _physics_process(delta):
	var mouse_pos = get_global_mouse_position()
	$Marker2D.look_at(mouse_pos)
	mover(delta)
	animate()
	texto_velocidade.text = str(int(velocity.length()))


func update_PlayerUI():
	set_texto_barra_de_vida()
	barra_vida.vida = vida
	mini_barra.vida = vida


func set_texto_barra_de_vida() -> void:
	texto_vida.text = "%s/%s" % [vida, vida_maxima]


func update_exp(_exp):
	exp += _exp
	barra_exp.value += exp
	if barra_exp.value >= barra_exp.max_value:
		print(barra_exp.value)
		barra_exp.value = 0
		print(barra_exp.value)
		barra_exp.max_value += 100
		print(barra_exp.max_value)
		nivel += 1 
		texto_nivel.text = str(nivel)
		exp = 0
		$level_up.play()
	

func mover(delta):
	axis = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if axis == Vector2.ZERO:
		state = IDLE
		aplicar_fricao(friccao * delta)
	else:
		state = MOVE
		blend_pos = axis
		aplicar_movimento(axis * aceleracao * delta)			
	move_and_slide()


func aplicar_fricao(qtd) -> void:
	if velocity.length() > qtd:
		velocity -= velocity.normalized() * qtd
	else:
		velocity = Vector2.ZERO


func aplicar_movimento(acelerac) -> void:
	velocity += acelerac
	velocity = velocity.limit_length(speed)


func animate() -> void:
	state_machine.travel(animTree_state_keys[state])
	animationTree.set(blend_pos_paths[state], blend_pos)
	

func _on_hurtbox_body_entered(body):
	if body.is_in_group("inimigos"):
		vida = barra_vida.vida - (body.dano - PlayerVariaveis.resistencia * 3)
		update_PlayerUI()
	if vida <= 0:
		morto()
		
		
# Colocar Area2D para pegar drops, se drop for Moedas, mundo.moedas_coletadas(moeda) #

func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path
	

func morto():
	Global.moedas += mundo.moedas
	Global.inimigos_derrotados += mundo.inimigos_abatidos
	Global.moedas += mundo.inimigos_abatidos
	Global.jogos_jogados += 1
	animacao_morte()
	queue_free()
	get_tree().change_scene_to_file("res://Menus/gameover.tscn")
	

func animacao_morte():
	var morreu = anim_morte.instantiate()
	morreu.global_position = global_position
	get_tree().get_root().add_child(morreu)
	get_tree().get_root().remove_child(morreu)
	
	
	
