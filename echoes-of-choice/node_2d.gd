extends Area2D

func _on_TeleportEscadas_body_entered(body):
	if body.has_method("player") and body.is_in_group("player"):
		print("Jogador a descer as escadas...")
		body.global_position = Vector2(935, 200)
