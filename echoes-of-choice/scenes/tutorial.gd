extends Node2D

func _ready():
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.village_sound, true)

func _process(delta):
	change_scene()
	

@onready var pause_menu := $PauseMenu  

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):  
		if not get_tree().paused:
			pause_menu.show_pause_menu()
		else:
			pause_menu.hide_pause_menu()



func _on_cidade_enter_body_entered(body: Node2D) -> void:
	if body.has_method("player") and body.is_in_group("player"):
		print("Jogador entrou na saída da caverna.")
		Global.transition_scene = true
		Global.target_scene = "cidade"


func _on_cidade_enter_body_exited(body: Node2D) -> void:
	if body.has_method("player") and body.is_in_group("player"):
		print("Jogador saiu da saída da caverna.")
		Global.transition_scene = false
		
# Função para mudar de cena
func change_scene():
	if Global.transition_scene == true:
		# Mudar para a cena correta dependendo do destino
		if Global.target_scene == "cidade":
			print("Mudando para a cidade (main_scene)...")
			get_tree().change_scene_to_file("res://scenes/control.tscn")
		Global.finish_changescenes()
