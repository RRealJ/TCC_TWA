extends Arma


func _ready():
	mundo = $"../../.."
	atirar()
	

func atirar():
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
			
			new_bullet.zindex = z_index
			mundo.add_child(new_bullet)
		await get_tree().create_timer(fire_rate).timeout
		can_shoot = true
		atirar()

