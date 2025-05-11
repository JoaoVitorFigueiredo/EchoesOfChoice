extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.game_first_loadin == true:
		$player.position.x = Global.player_start_cityx
		$player.position.y= Global.player_start_cityy
	else:
		$player.position.x = Global.player_exit_caverna_ladder_posx
		$player.position.y= Global.player_exit_caverna_ladder_posy


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
