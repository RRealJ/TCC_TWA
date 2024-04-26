extends Area2D


const duracao_pisca = 0.15
@export var esbranquisado:Resource


func _on_area_entered(area: Area2D) -> void:
	esbranquisado.set_shader_parameter("pisca", true)
	await get_tree().create_timer(duracao_pisca).timeout
	esbranquisado.set_shader_parameter("pisca", false)
