extends Area2D

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		var current_scene = Global.current_scene
		print(current_scene)
		Global.keys[current_scene] = true
		print("Chave apanhada para a cena:", current_scene)
		AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.pick_item, false)
		queue_free()
