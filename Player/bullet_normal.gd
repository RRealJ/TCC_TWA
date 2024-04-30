extends Bullet


func _on_bullet_vida_timeout():
	queue_free()
