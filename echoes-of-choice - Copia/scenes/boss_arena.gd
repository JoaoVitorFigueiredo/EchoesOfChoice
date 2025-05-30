extends Node2D

func _ready():
	print("Estás na arena do chefe.")

func _process(delta):
	change_scene()

# Quando o jogador entra na saída da arena (de volta para a caverna)
func _on_caverna_exit_point_body_entered(body):
	if body.has_method("player") and body.is_in_group("player"):
		print("Jogador entrou na saída da arena.")
		Global.transition_scene = true
		Global.target_scene = "caverna"

func _on_caverna_exit_point_body_exited(body):
	if body.has_method("player") and body.is_in_group("player"):
		print("Jogador saiu da saída da arena.")
		Global.transition_scene = false

func change_scene():
	if Global.transition_scene:
		match Global.target_scene:
			"caverna":
				print("Mudando para a caverna...")
				Global.last_scene = "boss_arena"
				get_tree().change_scene_to_file("res://scenes/Caverna.tscn")
			"boss_arena":
				print("Já estás na arena do boss.")
		
		Global.finish_changescenes()
