extends CharacterBody2D

class_name Bullet

var dir: float
var spawn_pos: Vector2
var spawn_rot: float
var zdex: int

@export var bullet_velocidade: float
@export var bullet_penetracao: int
@export var bullet_dano: int
@onready var bullet_vida:= $bullet_vida as Timer


func _ready():
	global_position = spawn_pos
	global_rotation = spawn_rot
	z_index = zdex
	
	
func _physics_process(delta):
	velocity = Vector2(0, -bullet_velocidade).rotated(dir)
	move_and_slide()
	
	
	
	
	
	
