extends Arma

@onready var menu_pausa = $"../../../camera/menu_pausa"
@onready var recompensas_ui = $"../../../camera/Recompensas"
@onready var inimigo = $".."


func _ready():
	mundo = $"../../.."
	if !inimigo.is_in_group("inimigo_boss"):
		atirar()
	

func atirar():
	if menu_pausa.visible == false && recompensas_ui.visible == false:
		if can_shoot:
			can_shoot = false 
			for i in bullet_qtd:
				var new_bullet = bullet.instantiate()
				new_bullet.position = global_position
				look_at(owner.target_pos)
				
				if bullet_qtd == 1:
					new_bullet.rotation = global_rotation
					new_bullet.dir = global_rotation
					
				else:
					var arc_rad = deg_to_rad(arc)
					var increment = arc_rad / (bullet_qtd - 1)
					var new_rotation = (global_rotation - arc_rad / 2) + (increment * i) 	
					new_bullet.global_rotation = new_rotation
					new_bullet.dir = new_rotation
				
				if inimigo.is_in_group("inimigo_boss"):
					if inimigo.state == 1:
						new_bullet.bullet_velocidade = 200
				new_bullet.zindex = z_index
				mundo.add_child(new_bullet)
			await get_tree().create_timer(fire_rate).timeout
			can_shoot = true
			if !inimigo.is_in_group("inimigo_boss"):
				atirar()

