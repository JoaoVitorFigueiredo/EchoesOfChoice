extends Area2D

func _on_TeleportEscadas_body_entered_key(body):
	if body.has_method("player") and body.is_in_group("player"):
		print("Jogador a subir as escadas...")
		body.global_position = Vector2(290, 270)
