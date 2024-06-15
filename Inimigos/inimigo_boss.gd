extends Inimigos

@onready var children = self.get_children()
@onready var shooter = $shooter
@onready var barra_vida = $barra_vida
@onready var vida_maxima = vida
var atirando = false
var pode_atirar = false
enum{NORMAL, FRENZY} #0, 1
var state = NORMAL



func _ready():
	print("||spawnado boss||")
	self.add_to_group("inimigo_boss")
	barra_vida.init_vida(vida)

		
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
	print(state)
	vida = vida - dano_recebido
	print(vida)
	print(vida_maxima)
	if vida <= vida_maxima/3:
		update_frenzy()
	update_vida()
	print('apos update_vida')
	print(vida, vida_maxima)
		
		
func atirar():
	if pode_atirar:
		pode_atirar = false
		atirando = true
		shooter.atirar() #configurar shooter em modo frenzy
		
		if state == 0:
			a_sprite.play("spit_attack")
		
		elif state == 1:
			a_sprite.play("spit_attack_frenzy")
			
		await get_tree().create_timer(2).timeout
		atirando = false
		

func update_frenzy():
	if !state == 1 or vida <= vida_maxima/7:
		print('Entrando em Frenzy')
		state = FRENZY
		speed = speed * 2
		speed_limit = speed_limit * 2
		dano = dano * 2
#colocar timer que ao acabar fará com que mude pode_atirar para true


func update_vida():
	barra_vida.value = vida
	if vida <= 0:
		morto()


func _on_hitbox_body_entered(body):
	if body.is_in_group("Bullets") or body is AreaArma:
		receber_dano(body.dano)


func _on_timer_atirar_timeout():
	if !atirando:
		pode_atirar = true
		atirar()
