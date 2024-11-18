extends Inimigo_boss

		
func atirar():
	if pode_atirar:
		pode_atirar = false
		atirando = true
		
		if state == 0:
			a_sprite.play("snake_attack")
		
		elif state == 1:
			var valores = Vector2(5.0, 5.0)
			$Sprite2D.material.set_shader_parameter("r_displacement", valores)
			valores = Vector2(-5.0, -5.0)
			$Sprite2D.material.set_shader_parameter("b_displacement", valores)
			a_sprite.play("snake_attack_frenzy")
			await get_tree().create_timer(0.3).timeout
			valores = Vector2(0.0, 0.0)
			$Sprite2D.material.set_shader_parameter("r_displacement", valores)
			$Sprite2D.material.set_shader_parameter("b_displacement", valores)
			
		shooter.atirar()
			
		await get_tree().create_timer(2).timeout
		atirando = false
		


func update_frenzy():
	if !state == 1:
		flashing()
		state = FRENZY
		speed = speed * 1.3
		speed_limit = speed_limit * 1.3
		dano = dano * 2
		chromo()
		
