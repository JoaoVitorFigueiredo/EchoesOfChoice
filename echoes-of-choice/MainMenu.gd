extends Control

var center: Vector2
@onready var node := $Control2  # O nó visual que vais mover

func _ready():
	%Play.pressed.connect(play)
	%Quit.pressed.connect(quit_game)
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.intro, false)

	update_center()

	# Garante que se adapta quando a janela muda de tamanho (incluindo fullscreen)
	get_viewport().size_changed.connect(update_center)

func play():
	get_tree().change_scene_to_file("res://scenes/intro.tscn")
	
func quit_game():
	get_tree().quit()

func _process(_delta):
	var tween = node.create_tween()
	var offset = center - get_global_mouse_position() * 0.1
	tween.tween_property(node, "position", offset, 1.0)

func update_center():
	center = get_viewport_rect().size / 2
	if node:
		node.global_position = center
