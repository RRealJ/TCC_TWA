extends Bullet

@onready var dano = bullet_dano
@onready var animacao


func _ready() -> void:
	$AnimatedSprite2D.play(animacao)
	if animacao == "snake_attack_frenzy":
		$AnimatedSprite2D/GPUParticles2D.visible = true


func _physics_process(delta: float) -> void:
	look_at($"../Player".global_position)
	var dir = global_rotation
	position += (Vector2.RIGHT*bullet_velocidade).rotated(dir) * delta


func _on_area_2d_body_entered(body):
	if get_tree().paused == false:
		if body is Player:
			bullet_penetracao -= 1
			body._on_hurtbox_body_entered(self)  #Function no player
			if bullet_penetracao <= 0:
				queue_free()
			


func _on_bullet_vida_timeout():
	queue_free()


func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.play(animacao)
