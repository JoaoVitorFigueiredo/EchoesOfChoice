extends Control  # Ou Panel, VBoxContainer, conforme a tua cena

func _ready():
	# Tempo em segundos que queres mostrar os créditos
	var tempo_creditos = 13.0
	await get_tree().create_timer(tempo_creditos).timeout
	get_tree().change_scene_to_file("res://scenes/control.tscn")
