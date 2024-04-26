extends CharacterBody2D

class_name Inimigo

@export var speed = 60
@onready var target = $"../../Player" #Cuidado com outros mundos, mundo_1 OK
@onready var soft_collisons = $softCollision

func _physics_process(delta):
	if target == null:
		get_tree().get_nodes_in_group("Player")[0]
	else:
		if soft_collisons.is_colliding():
			velocity += soft_collisons.get_push_vector() * delta * 400
		velocity = position.direction_to(target.position) * speed
		move_and_slide()
		
		
