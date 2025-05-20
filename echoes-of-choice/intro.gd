extends Control

@onready var anim_player := $AnimationPlayer
@onready var sprite := $Sprite2D  # Substitui pelo nome correto se for outro nó

func _ready():
	update_position()
	get_viewport().size_changed.connect(update_position)

	anim_player.play("fadeout")
	await get_tree().create_timer(6.0).timeout
	anim_player.play("fadein")
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")


func update_position():
	var center = get_viewport_rect().size / 2
	if sprite != null:
		sprite.position = center  # Para Sprite2D
		# Ou: sprite.rect_position = center - sprite.rect_size / 2  # Se for Control/TextureRect
