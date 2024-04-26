extends CharacterBody2D

class_name Player


const iFrame_duration = 1.5
@export var ACELERACAO = 500
@export var FRICCAO = 1000
@onready var axis = Vector2.ZERO
@onready var texto_vida = $player_ui/texto_barra_vida
@onready var texto_velocidade = $player_ui/texto_velocidade
@onready var remote_transform := $remote as RemoteTransform2D
@onready var gameover = $"../gameover"
@onready var barra_vida = $player_ui/barra_vida
@onready var mini_barra = $mini_barra
var max_speed = 75 * PlayerVariaveis.velocidade
var vida_maxima = 100 + (25 * PlayerVariaveis.vida)
var speed = max_speed
var vida = vida_maxima
var friccao = FRICCAO


func _ready():
	barra_vida.init_vida(vida)
	mini_barra.init_vida(vida)
	update_PlayerUI()
	
	
func _physics_process(delta):
	mover(delta)
	texto_velocidade.text = str(int(self.velocity.length()))
	
	
func update_PlayerUI():
	set_texto_barra_de_vida()
	barra_vida.vida = vida
	mini_barra.vida = vida


func set_texto_barra_de_vida() -> void:
	texto_vida.text = "%s/%s" % [vida, vida_maxima]
	
	
func mover(delta):
	axis = get_input_axis()
	
	if axis == Vector2.ZERO:
		aplicar_fricao(friccao * delta)
	else:
		aplicar_movimento(axis * ACELERACAO * delta)
		
	move_and_slide()
	

func get_input_axis():
	axis.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")) 
	axis.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up")) 
	return axis.normalized()
	
	
func aplicar_fricao(qtd):
	if velocity.length() > qtd:
		velocity -= velocity.normalized() * qtd
	else:
		velocity = Vector2.ZERO
		
		
func aplicar_movimento(acelerac):
	velocity += acelerac
	velocity = velocity.limit_length(speed)
	

func _on_hurtbox_body_entered(body):
	if body.is_in_group("inimigos"):
		vida = barra_vida.vida - (body.dano - PlayerVariaveis.resistencia * 3)
		update_PlayerUI()
	if vida <= 0:
		get_tree().change_scene_to_file("res://Menus/gameover.tscn")
		


func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path
	
