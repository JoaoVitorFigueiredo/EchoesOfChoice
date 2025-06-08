extends Node2D

func _ready():
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.village_sound, true)

func _process(delta):
	change_scene()
	


func _on_cidade_enter_body_entered(body: Node2D) -> void:
	if body.has_method("player") and body.is_in_group("player"):
		print("Jogador entrou na saída da caverna.")
		Global.transition_scene = true
		Global.target_scene = "cidade"


func _on_cidade_enter_body_exited(body: Node2D) -> void:
	if body.has_method("player") and body.is_in_group("player"):
		print("Jogador saiu da saída da caverna.")
		Global.transition_scene = false
		
func change_scene():
	if Global.transition_scene == true:
		if Global.target_scene == "cidade":
			print("Mudando para a cidade (main_scene)...")
			get_tree().change_scene_to_file("res://scenes/control.tscn")
		Global.finish_changescenes()
