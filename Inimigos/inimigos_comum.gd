extends CharacterBody2D

class_name Inimigo

@export var speed = 60
@onready var target = $"../../Player" #Cuidado com outros mundos, mundo_1 OK

func _physics_process(delta):
	if target == null:
		get_tree().get_nodes_in_group("Player")[0]
	else:
		velocity = position.direction_to(target.position) * speed
		move_and_slide()
