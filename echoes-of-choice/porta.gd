extends Node2D

func _ready():
	# Ativar sinais para todas as tábuas
	for tabua in get_children():
		if tabua is Area2D:
			tabua.connect("body_entered", _on_tabua_body_entered)

func _on_tabua_body_entered(body):
	if body is CharacterBody2D and body.is_in_group("player"):
		if Global.key_found:
			print("Chave encontrada. Abrir porta!")

			for tabua in get_children():
				if tabua is Area2D:  # Verifique se ainda estamos a trabalhar com a Area2D
					tabua.visible = false
				
					# Procurar o StaticBody2D dentro de cada tábua
					var static_body = tabua.get_node("StaticBody2D")
					if static_body:
						# Acessar e remover o CollisionShape2D (com nome "static") dentro do StaticBody2D
						var collision = static_body.get_node("static")  # Novo nome de colisão
						if collision:
							collision.queue_free()  # Remover a colisão da cena
						
						# Opcional: Pode também remover a visibilidade do StaticBody2D, se necessário
						static_body.visible = false

		else:
			print("A porta está trancada. Precisas da chave.")
