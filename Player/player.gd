extends CharacterBody2D


@export var MAX_SPEED = 75
@export var ACELERACAO = 500
@export var FRICCAO = 1000
@onready var axis = Vector2.ZERO

func _physics_process(delta):
	mover(delta)
	
	
func get_input_axis():
	axis.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")) 
	axis.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up")) 
	return axis.normalized()
	
	
func mover(delta):
	axis = get_input_axis()
	
	if axis == Vector2.ZERO:
		aplicar_fricao(FRICCAO * delta)
	else:
		aplicar_movimento(axis * ACELERACAO * delta)
		
	move_and_slide()
	
	
func aplicar_fricao(qtd):
	if velocity.length() > qtd:
		velocity -= velocity.normalized() * qtd
	else:
		velocity = Vector2.ZERO
		
		
func aplicar_movimento(acelerac):
	velocity += acelerac
	velocity = velocity.limit_length(MAX_SPEED)
	
	
