extends CharacterBody2D

class_name Player

signal PlayerDeath

const iFrame_duration = 1.5
@export var max_speed = 75 * PlayerVariaveis.velocidade
@export var ACELERACAO = 500 * PlayerVariaveis.velocidade
@export var FRICCAO = 1000 * PlayerVariaveis.velocidade
@export var inv: Inv
@onready var axis = Vector2.ZERO
@onready var recompensas_ui = $"../camera/Recompensas/recompensas_ui"
@onready var texto_vida = $player_ui/sup_esquerda/texto_barra_vida
@onready var texto_velocidade = $player_ui/inf_direita/texto_velocidade
@onready var remote_transform := $remote as RemoteTransform2D
@onready var gameover = $"../gameover"
@onready var barra_vida = $player_ui/sup_esquerda/barra_vida
@onready var mini_barra = $mini_barra
@onready var anim_sprite = $anim
@onready var anim = $animation
@onready var animationTree = $AnimationTree
@onready var state_machine = animationTree["parameters/playback"]
@onready var anim_morte = preload("res://Efeitos/morte_vfx.tscn")
@onready var mundo = $".."
@onready var barra_exp = $"player_ui/inferior/barra_exp"
@onready var exp := 0 as int
@onready var nivel := 1 as int
@onready var texto_nivel = $"player_ui/inf_esquerda/texto_nivel"
@onready var menu_pausa = $"../camera/menu_pausa"


var vida_maxima = 100 + 25 * PlayerVariaveis.vida
var vida = vida_maxima
var speed = max_speed
var aceleracao = ACELERACAO
var friccao = FRICCAO
var resistencia = PlayerVariaveis.resistencia * 3
enum{IDLE, MOVE}
var state = IDLE

var blend_pos: Vector2 = Vector2.ZERO
var blend_pos_paths = [
	"parameters/idle/idle_bs2d/blend_position",
	"parameters/move/move_bs2D/blend_position"
]

var animTree_state_keys = [
	"idle",
	"move"
]

func _ready():
	limpar_inventario()
	barra_exp.min_value = 0
	barra_exp.max_value = 100
	barra_exp.value = 0
	$player_ui/sup_direito/contagem_inimigos.text = "0"
	$player_ui/sup_direito/contagem_moedas.text = "0"
	barra_vida.init_vida(vida)
	mini_barra.init_vida(vida)
	update_PlayerUI()
	
	
func _physics_process(delta):
	var mouse_pos = get_global_mouse_position()
	$Marker2D.look_at(mouse_pos)
	mover(delta)
	animate()
	texto_velocidade.text = str(int(velocity.length()))


func update_PlayerUI():
	barra_vida.vida = vida
	mini_barra.vida = vida
	set_texto_barra_de_vida()


func set_texto_barra_de_vida() -> void:
	texto_vida.text = "%s/%s" % [vida, vida_maxima]


func update_exp(_exp):
	exp += _exp
	barra_exp.value += exp
	if barra_exp.value >= barra_exp.max_value:
		level_up()
		

func level_up():
	barra_exp.value = 0
	if nivel <= 10:
		barra_exp.max_value += 250
	nivel += 1 
	texto_nivel.text = str(nivel)
	exp = 0
	$level_up.play()
	recompensas_ui.upgrade()
	
	

func mover(delta):
	axis = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if axis == Vector2.ZERO:
		state = IDLE
		aplicar_fricao(friccao * delta)
	else:
		state = MOVE
		blend_pos = axis
		aplicar_movimento(axis * aceleracao * delta)			
	move_and_slide()


func aplicar_fricao(qtd) -> void:
	if velocity.length() > qtd:
		velocity -= velocity.normalized() * qtd
	else:
		velocity = Vector2.ZERO


func aplicar_movimento(acelerac) -> void:
	velocity += acelerac
	velocity = velocity.limit_length(speed)


func animate() -> void:
	state_machine.travel(animTree_state_keys[state])
	animationTree.set(blend_pos_paths[state], blend_pos)
	

func _on_hurtbox_body_entered(body):
	if menu_pausa.visible == false:
		if body is Inimigos or body.is_in_group("inimigos"):
			vida = barra_vida.vida - (body.dano - resistencia)
			update_PlayerUI()
		if vida <= 0:
			morto()
		

func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path
	


func salvar():
	Global.moedas += mundo.moedas
	Global.inimigos_derrotados += mundo.inimigos_abatidos
	Global.moedas += mundo.inimigos_abatidos
	Global.jogos_jogados += 1
	
	
	
func morto():
	salvar()
	animacao_morte()
	limpar_inventario()
	queue_free()
	get_tree().change_scene_to_file("res://Menus/gameover.tscn")
	

func animacao_morte():
	var morreu = anim_morte.instantiate()
	morreu.global_position = global_position
	get_tree().get_root().add_child(morreu)
	get_tree().get_root().remove_child(morreu)
	
	
	
func limpar_inventario():
	inv.limpar()
	

func inserir(item): #inserir no iventário()
	if item is PackedScene:
		var passou = true
		var i = item.instantiate()
		for slot in inv.slots:
			if slot.item == i.item: passou = false
		if passou:
			$".".add_child(i)
		inv.insert(i.item)

	else:
		if item.nome == "Upgrade Vida":
			vida_maxima = vida_maxima + 25
			mini_barra.max_value = vida_maxima
			barra_vida.max_value = vida_maxima
			$"player_ui/sup_esquerda/barra_vida/barra_dano".max_value = vida_maxima
			$"mini_barra/barra_dano".max_value = vida_maxima
			vida = vida + 25
			update_PlayerUI()
			
		elif item.nome == "Upgrade Velocidade":
			speed = speed + 75
			friccao = friccao + 400
		
		elif item.nome == "Upgrade Defesa":
			resistencia = resistencia + 5

