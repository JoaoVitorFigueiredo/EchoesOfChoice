extends Control

var center : Vector2
@onready var node = $Control2

func _ready():
	%Play.pressed.connect(play)
	%Quit.pressed.connect(quit_game)
	center = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)

func play():
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")
	
func quit_game():
	get_tree().quit()
	
func _process(_delta):
	var tween = node.create_tween()
	var offset = center - get_global_mouse_position() * 0.1
	tween.tween_property(node,"position", offset, 1.0)


func _on_item_rect_changed():
	center = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
	if node != null:
		node.global_position = center
	
