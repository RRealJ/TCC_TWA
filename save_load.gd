extends Node2D

class_name Save_Load


const SAVE_PATH = "user://globais_e_player"

#settings
var diminuir_bgm_ao_pausar:= true as bool
var fullscreen := false as bool
var sem_bordas := false as bool
var vsync := false as bool
var hs_master = 1
var hs_bgm = 0.5
var hs_sfx = 0.5

#globais-status
var moedas:= 0 as int
var inimigos_derrotados:= 0 as int
var bosses_derrotados:= 0 as int
var jogos_completados:= 0 as int
var jogos_iniciados:= 0 as int
var conquista_completadas:= 0 as int

#player_variavel
var velocidade := 1
var vida := 1
var dano := 1
var sorte := 1
var chance_critica := 1
var resistencia := 1
var penetracao := 3

func save():
	update_data_in_save()
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(diminuir_bgm_ao_pausar)
	file.store_var(fullscreen)
	file.store_var(sem_bordas)
	file.store_var(vsync)
	file.store_var(hs_master)
	file.store_var(hs_bgm)
	file.store_var(hs_sfx)
	
	file.store_var(moedas)
	file.store_var(inimigos_derrotados)
	file.store_var(bosses_derrotados)
	file.store_var(jogos_completados)
	file.store_var(jogos_iniciados)
	file.store_var(conquista_completadas)
	
	file.store_var(velocidade)
	file.store_var(vida)
	file.store_var(dano)
	file.store_var(sorte)
	file.store_var(chance_critica)
	file.store_var(resistencia)
	file.store_var(penetracao)
	

func update_data_in_save():
	diminuir_bgm_ao_pausar = Global.diminuir_bgm_ao_pausar
	fullscreen = Global.fullscreen
	sem_bordas = Global.sem_bordas
	vsync = Global.vsync
	moedas = Global.moedas
	inimigos_derrotados = Global.inimigos_derrotados
	bosses_derrotados = Global.bosses_derrotados
	jogos_completados = Global.jogos_completados
	jogos_iniciados = Global.jogos_iniciados
	conquista_completadas = Global.conquista_completadas
	velocidade = PlayerVariaveis.velocidade
	vida = PlayerVariaveis.vida
	dano = PlayerVariaveis.dano
	sorte = PlayerVariaveis.sorte
	chance_critica = PlayerVariaveis.chance_critica
	resistencia = PlayerVariaveis.resistencia
	penetracao = PlayerVariaveis.penetracao
	
	
func update_data_in_variables():
	Global.diminuir_bgm_ao_pausar = diminuir_bgm_ao_pausar
	Global.fullscreen = fullscreen
	Global.sem_bordas = sem_bordas
	Global.vsync = vsync
	Global.moedas = moedas
	Global.inimigos_derrotados = inimigos_derrotados
	Global.bosses_derrotados = bosses_derrotados
	Global.jogos_completados = jogos_completados
	Global.jogos_iniciados = jogos_iniciados
	Global.conquista_completadas = conquista_completadas
	PlayerVariaveis.velocidade = velocidade
	PlayerVariaveis.vida = vida
	PlayerVariaveis.dano = dano
	PlayerVariaveis.sorte = sorte
	PlayerVariaveis.chance_critica = chance_critica
	PlayerVariaveis.resistencia = resistencia
	PlayerVariaveis.penetracao = penetracao


func load_data():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		diminuir_bgm_ao_pausar = file.get_var(diminuir_bgm_ao_pausar)
		fullscreen = file.get_var(fullscreen)
		sem_bordas = file.get_var(sem_bordas)
		vsync = file.get_var(vsync)
		hs_master = file.get_var(hs_master)
		hs_sfx = file.get_var(hs_sfx)
		hs_bgm = file.get_var(hs_bgm)
		
		moedas = file.get_var(moedas)
		inimigos_derrotados = file.get_var(inimigos_derrotados)
		bosses_derrotados = file.get_var(bosses_derrotados)
		jogos_completados = file.get_var(jogos_completados)
		jogos_iniciados = file.get_var(jogos_iniciados)
		conquista_completadas = file.get_var(conquista_completadas)
		velocidade = file.get_var(velocidade)
		vida = file.get_var(vida)
		dano = file.get_var(dano)
		sorte = file.get_var(sorte)
		chance_critica = file.get_var(chance_critica)
		resistencia = file.get_var(resistencia)
		penetracao = file.get_var(penetracao)
		update_data_in_variables()	
		
	else:
		printerr("Nenhum Save foi encontrado...")
