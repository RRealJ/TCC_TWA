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
	if !state == 1:
		$AnimatedSprite2D.play("frenzy_transform")
		state = FRENZY
		speed = speed * 2
		speed_limit = speed_limit * 2
		dano = dano * 2
		await get_tree().create_timer(4).timeout
		
#colocar timer que ao acabar fará com que mude pode_atirar para true


func update_vida():
	barra_vida.vida = vida
	if vida <= 0:
		morto()
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
