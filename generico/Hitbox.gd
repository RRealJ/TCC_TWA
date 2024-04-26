extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		pass
		#owner.queue_free() - caso precise remover inimigo apos colisão
		#owner.anim.play("hurt") - caso precise que toque uma animação
