extends Node2D

#settings
var diminuir_bgm_ao_pausar:= true as bool # vai q a pessoa precisa salvar
var fullscreen := false as bool
var sem_bordas := false as bool
var vsync := false as bool

#---- status ----
var moedas:= 0 as int
var inimigos_derrotados:= 0 as int
var bosses_derrotados:= 0 as int
var jogos_completados:= 0 as int
var jogos_iniciados:= 0 as int
var conquista_completadas:= 0 as int
var player_win:= true as bool
var mundo_atual: int
