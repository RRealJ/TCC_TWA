extends Inimigos

@onready var children = self.get_children()
@onready var shooter = $shooter
var vida_maxima = vida
var pode_atirar = false


enum{NORMAL, FRENZY}
var state = NORMAL


func _ready():
	self.add_to_group("inimigo_boss")
		
		
func _physics_process(delta):
	velocity = position.direction_to(target.position) * speed
	move_and_slide()
	if state == 0: #normal
		a_sprite.play("andar")
		
	elif state == 1: #frenzy
		pass
		a_sprite.play("andar_frenzy")
		
	if (target.position.x - position.x) < 0:
		a_sprite.flip_h = true
	else:
		a_sprite.flip_h = false
		
	target_pos = target.global_position
	
	
func receber_dano(dano_recebido):
	vida = vida - dano_recebido
	if vida == int(vida_maxima / 3):
		update_frenzy()
		
		
func atirar():
	if pode_atirar:
		pode_atirar = false
		shooter.atirar() #configurar shooter em modo frenzy
		
		if state == 0:
			pass
			a_sprite.play("attack_spit")
		
		elif state == 1:
			pass
			a_sprite.play("attack_spit_frenzy")
		

func update_frenzy():
	print('Entrando em Frenzy')
	dano = dano * 2
	speed_limit = speed_limit * 3
	speed = speed * 3
	
	
#colocar timer que ao acabar fará com que mude pode_atirar para true

