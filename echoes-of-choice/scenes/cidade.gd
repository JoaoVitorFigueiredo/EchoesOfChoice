extends Node2D


func _ready():
	$player.position.x = Global.player_start_cityx
	$player.position.y= Global.player_start_cityy
	
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.village_sound, true)

func _process(delta):
	change_scene()


func _on_caverna_body_entered(body):
	if body.has_method("player") and body.is_in_group("player"):
		print(1)
		Global.transition_scene = true


func _on_caverna_body_exited(body):
	if body.has_method("player") and body.is_in_group("player"):
		print(1)
		Global.transition_scene = false

func change_scene():
	if Global.transition_scene == true:
		Global.game_first_loadin = false
		get_tree().change_scene_to_file("res://scenes/Caverna.tscn")
		Global.finish_changescenes()
