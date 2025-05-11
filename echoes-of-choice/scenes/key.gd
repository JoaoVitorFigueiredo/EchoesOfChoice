extends Area2D

func _on_Area2D_body_entered(body):
	if body.has_method("player") and body.is_in_group("player"):
		print("O jogador apanhou a chave!")
		Global.key_found = true
		queue_free()
