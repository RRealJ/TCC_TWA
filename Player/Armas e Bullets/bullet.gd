extends CharacterBody2D

class_name Bullet

var zindex:= 1 as int
var dir: float


@onready var inv: Inv = preload("res://Inventario/player_inv.tres")
@export var item: InvItem
@export var bullet_velocidade: float
@export var bullet_penetracao:= PlayerVariaveis.penetracao as int
@export var bullet_dano: int
@onready var bullet_vida:= $bullet_vida as Timer
@onready var menu_pausa = $"../camera/menu_pausa"
@onready var recompensas_ui = $"../camera/Recompensas"
@onready var player = $"../Player"


func _ready():
	z_index = zindex
	

func _physics_process(delta):
	position += (Vector2.RIGHT*bullet_velocidade).rotated(dir) * delta
	
	


	
