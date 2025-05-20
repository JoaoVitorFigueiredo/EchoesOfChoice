extends Area2D

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		var current_scene = Global.current_scene
		print(current_scene)
		Global.keys[current_scene] = true
		print("Chave apanhada para a cena:", current_scene)
		queue_free()
