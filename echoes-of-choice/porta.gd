extends Node2D

func _ready():
	for tabua in get_children(): 
		if tabua is Area2D:
			tabua.connect("body_entered", _on_tabua_body_entered)

func _on_tabua_body_entered(body):
	print("teste")
	if body is CharacterBody2D and body.is_in_group("player"):
		var current_scene = Global.current_scene
		var has_key = Global.keys.get(current_scene)  #obtém o estado da chave para a cena atual
		print(has_key)
		if has_key:
			print("Chave encontrada. Abrir porta!")

			for tabua in get_children():
				if tabua is Area2D:
					tabua.visible = false

					var static_body = tabua.get_node("StaticBody2D")
					if static_body:
						var collision = static_body.get_node("static")
						if collision:
							collision.queue_free()

						static_body.visible = false
		else:
			print("A porta está trancada. Precisas da chave.")
