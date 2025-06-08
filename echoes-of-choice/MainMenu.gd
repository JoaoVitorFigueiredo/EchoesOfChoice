extends Control

var center: Vector2
@onready var node := $Control2  

func _ready():
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.intro, false)
	%Play.pressed.connect(play)
	%Tutorial.pressed.connect(tutorial)
	%Settings.pressed.connect(settings)
	%Quit.pressed.connect(quit_game)
	update_center()
	get_viewport().size_changed.connect(update_center)

func play():
	AudioManager.stop()
	get_tree().change_scene_to_file("res://scenes/intro.tscn")
	
func tutorial():
	AudioManager.stop()
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")
	
func settings():
	AudioManager.stop()
	get_tree().change_scene_to_file("res://scenes/settings.tscn")
	
func quit_game():
	AudioManager.stop()
	get_tree().quit()

func _process(_delta):
	var tween = node.create_tween()
	var offset = center - get_global_mouse_position() * 0.1
	tween.tween_property(node, "position", offset, 1.0)

func update_center():
	center = get_viewport_rect().size / 2
	if node:
		node.global_position = center
