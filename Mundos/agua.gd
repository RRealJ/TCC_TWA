extends Area2D

@onready var player = $"../Player"

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.speed = body.speed/1.2
		body.aceleracao = body.aceleracao/1.2


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.speed = body.speed * 1.2 + 1
		body.aceleracao = body.aceleracao * 1.2 + 1
