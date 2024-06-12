extends Node2D

class_name Arma

@onready var inv: Inv = preload("res://Inventario/player_inv.tres")
@export var item: InvItem
@export var bullet: PackedScene
@export var bullet_qtd: int = 1
@export_range(0, 360) var arc: float = 0
@export_range(0, 20) var fire_rate: float = 1.0
@onready var mundo = $"../../"
var can_shoot = true


func _ready():
	atirar()


func _physics_process(delta):
	look_at(get_global_mouse_position())


func atirar():
	if can_shoot:
		can_shoot = false 
		for i in bullet_qtd:
			var new_bullet = bullet.instantiate()
			new_bullet.position = global_position
			
			if bullet_qtd == 1:
				new_bullet.rotation = global_rotation
				new_bullet.dir = global_rotation
				
			else:
				var arc_rad = deg_to_rad(arc)
				var increment = arc_rad / (bullet_qtd - 1)
				var new_rotation = (global_rotation - arc_rad / 2) + (increment * i) 	
				new_bullet.global_rotation = new_rotation
				new_bullet.dir = new_rotation
			
			new_bullet.zindex = z_index
			mundo.add_child(new_bullet)
		await get_tree().create_timer(1 / fire_rate).timeout
		can_shoot = true
		atirar()
	


