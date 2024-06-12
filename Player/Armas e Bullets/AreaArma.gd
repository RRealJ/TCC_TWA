extends Area2D


class_name AreaArma

@onready var inv: Inv = preload("res://Inventario/player_inv.tres")
@export var item: InvItem
@export var dano:int = 15
@export_range(0, 20) var fire_rate: float = 1.0
@onready var mundo = $"../../"
var can_shoot = true


func _ready():
	atirar()
	
	
func atirar():
	$AnimatedSprite2D.play("area_attack")
	if can_shoot:
		can_shoot = false
		await get_tree().create_timer(1 / fire_rate).timeout
	can_shoot = true
	atirar()
		

func _on_body_entered(body):
	if body is Inimigos:
		body._on_hitbox_body_entered(self)
	await get_tree().create_timer(1 / fire_rate).timeout


func colidindo() -> void:
	#await serve pra n ficar repetindo o dano infitinamente no msm inimigo
	var lista_inimigos = get_overlapping_bodies()
	for i in lista_inimigos:
		i._on_hitbox_body_entered(self)
	

func _on_verificacao_timeout():
	if has_overlapping_bodies(): #existem bodies da mask dentro? true/false
		colidindo()
