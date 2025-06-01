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
	if sprite != null and sprite.texture != null:
		var viewport_size = get_viewport_rect().size
		var texture_size = sprite.texture.get_size()
		
		# Calcula o fator de escala necessário para preencher o ecrã
		var scale_x = viewport_size.x / texture_size.x
		var scale_y = viewport_size.y / texture_size.y
		var scale = max(scale_x, scale_y)  # Preencher o ecrã sem deixar espaço

		sprite.scale = Vector2(scale, scale)

		# Centraliza o sprite no ecrã
		sprite.position = viewport_size / 2
