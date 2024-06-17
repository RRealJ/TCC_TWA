extends Inimigos

@onready var children = self.get_children()
@onready var shooter = $shooter
@onready var barra_vida = $barra_vida
@onready var vida_maxima = vida
var atirando = false
var pode_atirar = false
enum{NORMAL, FRENZY} #0, 1
var state = NORMAL

signal boss_morto

func _ready():
	mundo.boss = $"."
	mundo.conectar_boss()
	print("||spawnado boss||")
	self.add_to_group("inimigo_boss")
	barra_vida.init_vida(vida_maxima)
	barra_vida.max_value = vida_maxima

		
func _physics_process(delta):
	velocity = position.direction_to(target.position) * speed
	move_and_slide()
	
	if !atirando:
		if state == 0:
			a_sprite.play("andar")
			
		elif state == 1:
			a_sprite.play("andar_frenzy")
		
	if (target.position.x - position.x) < 0:
		a_sprite.flip_h = true
	else:
		a_sprite.flip_h = false
		
	target_pos = target.global_position
	
	
func receber_dano(dano_recebido):
	vida = vida - dano_recebido
	if vida <= vida_maxima/3:
		update_frenzy()
	update_vida()

		
		
func atirar():
	if pode_atirar:
		pode_atirar = false
		atirando = true
		shooter.atirar() #configurar shooter em modo frenzy
		
		if state == 0:
			a_sprite.play("spit_attack")
		
		elif state == 1:
			var valores = Vector2(5.0, 5.0)
			$Sprite2D.material.set_shader_parameter("r_displacement", valores)
			valores = Vector2(-5.0, -5.0)
			$Sprite2D.material.set_shader_parameter("b_displacement", valores)
			a_sprite.play("spit_attack_frenzy")
			await get_tree().create_timer(0.3).timeout
			valores = Vector2(0.0, 0.0)
			$Sprite2D.material.set_shader_parameter("r_displacement", valores)
			$Sprite2D.material.set_shader_parameter("b_displacement", valores)
			
		await get_tree().create_timer(2).timeout
		atirando = false
		

func update_frenzy():
	if !state == 1:
		flashing()
		state = FRENZY
		speed = speed * 2
		speed_limit = speed_limit * 2
		dano = dano * 2
		chromo()
		
#colocar timer que ao acabar fará com que mude pode_atirar para true
func update_vida():
	barra_vida.vida = vida
	if vida <= 0:
		morto()
		Global.bosses_derrotados += 1
		print('BOSS DERROTADO!!!')
		boss_morto.emit()
	

func _on_hitbox_body_entered(body):
	if body.is_in_group("Bullets") or body is AreaArma:
		receber_dano(body.dano)


func _on_timer_atirar_timeout():
	if !atirando:
		pode_atirar = true
		atirar()


func drop_coin():
	var valor_moeda = int(randi_range(ouro * PlayerVariaveis.sorte, ouro * 2 * PlayerVariaveis.sorte))
	mundo.count_moedas(valor_moeda)
	

func flashing():
	a_sprite.material.set_shader_parameter("flash_mofidifier", 1)
	await get_tree().create_timer(0.5).timeout
	
	a_sprite.material.set_shader_parameter("flash_mofidifier", 0.5)
	await get_tree().create_timer(0.5).timeout
	
	a_sprite.material.set_shader_parameter("flash_mofidifier", 1)
	await get_tree().create_timer(0.5).timeout
	
	a_sprite.material.set_shader_parameter("flash_mofidifier", 0.0)
	

func chromo():
	var valores = Vector2(5.0, 5.0)
	$Sprite2D.material.set_shader_parameter("r_displacement", valores)
	valores = Vector2(-5.0, -5.0)
	$Sprite2D.material.set_shader_parameter("b_displacement", valores)
	await get_tree().create_timer(0.5).timeout
	
	valores = Vector2(20.0, -20.0)
	$Sprite2D.material.set_shader_parameter("r_displacement", valores)
	valores = Vector2(-20.0, 20.0)
	$Sprite2D.material.set_shader_parameter("b_displacement", valores)
	await get_tree().create_timer(0.5).timeout
	
	valores = Vector2(50.0, 50.0)
	$Sprite2D.material.set_shader_parameter("r_displacement", valores)
	valores = Vector2(-50.0, -50.0)
	$Sprite2D.material.set_shader_parameter("b_displacement", valores)
	await get_tree().create_timer(0.5).timeout
	
	valores = Vector2(5.0, 5.0)
	$Sprite2D.material.set_shader_parameter("r_displacement", valores)
	valores = Vector2(-5.0, -5.0)
	$Sprite2D.material.set_shader_parameter("b_displacement", valores)
	await get_tree().create_timer(0.5).timeout
	
	valores = Vector2(0.0, 0.0)
	$Sprite2D.material.set_shader_parameter("r_displacement", valores)
	$Sprite2D.material.set_shader_parameter("b_displacement", valores)
	
