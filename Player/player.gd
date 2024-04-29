extends CharacterBody2D

class_name Player


const iFrame_duration = 1.5
@export var max_speed = 75 * PlayerVariaveis.velocidade
@export var ACELERACAO = 500 * PlayerVariaveis.velocidade
@export var FRICCAO = 1000 * PlayerVariaveis.velocidade
@onready var axis = Vector2.ZERO
@onready var texto_vida = $player_ui/texto_barra_vida
@onready var texto_velocidade = $player_ui/texto_velocidade
@onready var remote_transform := $remote as RemoteTransform2D
@onready var gameover = $"../gameover"
@onready var barra_vida = $player_ui/barra_vida
@onready var mini_barra = $mini_barra
@onready var anim_sprite = $anim
@onready var anim = $animation
@onready var animationTree = $AnimationTree
@onready var state_machine = animationTree["parameters/playback"]

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
	barra_vida.init_vida(vida)
	mini_barra.init_vida(vida)
	update_PlayerUI()


func _physics_process(delta):
	mover(delta)
	animate()
	texto_velocidade.text = str(int(self.velocity.length()))


func update_PlayerUI():
	set_texto_barra_de_vida()
	barra_vida.vida = vida
	mini_barra.vida = vida


func set_texto_barra_de_vida() -> void:
	texto_vida.text = "%s/%s" % [vida, vida_maxima]


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
		get_tree().change_scene_to_file("res://Menus/gameover.tscn")


func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path
	
