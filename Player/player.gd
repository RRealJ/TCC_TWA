extends CharacterBody2D

class_name Player


var vida_maxima = 100 + (5 * PlayerVariaveis.vida)
var vida = vida_maxima
@export var MAX_SPEED = 75 * PlayerVariaveis.velocidade
@export var ACELERACAO = 500
@export var FRICCAO = 1000
@onready var axis = Vector2.ZERO
@onready var texto_vida = $player_ui/texto_barra_vida
@onready var barra_vida = $player_ui/barra_vida

func _ready():
	barra_vida.max_value = vida_maxima
	update_PlayerUI()
	
func _physics_process(delta):
	mover(delta)
	
	
func update_PlayerUI():
	set_barra_de_vida()
	set_texto_barra_de_vida()


func set_texto_barra_de_vida() -> void:
	texto_vida.text = "%s/%s" % [vida, vida_maxima]
	
	
func set_barra_de_vida() -> void:
	barra_vida.value = vida
	
	
func mover(delta):
	axis = get_input_axis()
	
	if axis == Vector2.ZERO:
		aplicar_fricao(FRICCAO * delta)
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
	velocity = velocity.limit_length(MAX_SPEED)
	

