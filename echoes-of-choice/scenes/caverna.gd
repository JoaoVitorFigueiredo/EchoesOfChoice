extends Node2D
var current_scene = Global.current_scene

func _ready():
	if Global.keys[current_scene]:
		print("Tens a chave! Podes entrar na arena do chefe.")
	else:
		print("Precisas da chave para entrar na arena do chefe.")
	if Global.last_scene == "boss_arena" and Global.target_scene == "caverna":
		print("mudar posição")
		$player.position.x = Global.player_return_from_boss_caverna_posx
		$player.position.y= Global.player_return_from_boss_caverna_posy
	
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.rocks_fall, true)

func _process(delta):
	change_scene()

#entra na área da saída da caverna (para a cidade)
func _on_caverna_exit_point_body_entered(body):
	if body.has_method("player") and body.is_in_group("player"):
		print("Jogador entrou na saída da caverna.")
		Global.transition_scene = true
		Global.target_scene = "cidade" 

#sai da área da saída da caverna (para a cidade)
func _on_caverna_exit_point_body_exited(body):
	if body.has_method("player") and body.is_in_group("player"):
		print("Jogador saiu da saída da caverna.")
		Global.transition_scene = false

#entra na área da arena do chefe
func _on_boss_enter_point_body_entered(body):
	if body.has_method("player") and body.is_in_group("player"):
		print("Jogador entrou na entrada da arena do chefe.")
		if Global.keys[current_scene]:  
			Global.transition_scene = true
			Global.target_scene = "boss_arena"  
		else:
			print("A porta está trancada. Precisas da chave.")

#sai da área da arena do chefe
func _on_boss_enter_point_body_exited(body):
	if body.has_method("player") and body.is_in_group("player"):
		print("Jogador saiu da entrada da arena do chefe.")
		Global.transition_scene = false

func change_scene():
	if Global.transition_scene == true:
		if Global.target_scene == "cidade":
			print("Mudando para a cidade (main_scene)...")
			get_tree().change_scene_to_file("res://scenes/main_scene.tscn")
		elif Global.target_scene == "boss_arena":
			print("Mudando para a arena do chefe (boss_arena)...")
			get_tree().change_scene_to_file("res://scenes/boss_arena.tscn")
		
		Global.finish_changescenes()
