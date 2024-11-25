extends Area2D


class_name AreaArma

@onready var inv: Inv = preload("res://Inventario/player_inv.tres")
@export var item: InvItem
@export var bullet_dano:int = 15
@export_range(0, 20) var fire_rate: float = 1.0
@onready var mundo = $"../../"
@onready var menu_pausa = $"../../camera/menu_pausa"
@onready var recompensas_ui = $"../../camera/Recompensas"
@onready var dano = bullet_dano * PlayerVariaveis.dano
@onready var player = $".."

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
	if get_tree().paused == false:
		var critico = randf()
		dano = bullet_dano * player.dano_add * item.level
		print(critico)
		if critico < player.chance_critica:
			dano = dano * 2
		print("Area Instavel dano: ",dano, "| level: ", item.level)
		if (body is Inimigos) or (body is Inimigo_boss):
			body._on_hitbox_body_entered(self)
		await get_tree().create_timer(1 / fire_rate).timeout


func colidindo() -> void:
	dano = bullet_dano * item.level * player.dano_add
	var lista_inimigos = get_overlapping_bodies()
	for i in lista_inimigos:
		i._on_hitbox_body_entered(self)
	

func _on_verificacao_timeout():
	if menu_pausa.visible == false && recompensas_ui.visible == false:
		if has_overlapping_bodies(): #existem bodies da mask dentro? true/false
			colidindo()
		
