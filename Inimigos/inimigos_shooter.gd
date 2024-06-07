extends Inimigos

var can_shoot = true
@export var bullet: PackedScene
@export var bullet_qtd: int = 1
@export_range(0, 360) var arc: float = 0
@export_range(0, 20) var fire_rate: float = 3.0
@onready var barra_vida = $barra_vida

func _ready():
	barra_vida.init_vida(vida)
	atirar()


func update_vida():
	barra_vida.value = vida
	if vida <= 0:
		morto()


func _on_hitbox_body_entered(body):
	if body is AreaArma or body is Bullet:
		receber_dano(body.dano)
		update_vida()


func atirar():
	if can_shoot:
		can_shoot = false 
		for i in bullet_qtd:
			var new_bullet = bullet.instantiate()
			new_bullet.position = global_position
			look_at(target_pos)
			
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
		await get_tree().create_timer(3 / fire_rate).timeout
		can_shoot = true
		atirar()
