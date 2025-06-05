extends CanvasLayer

func _ready() -> void:
	hide()
	print("3")

func show_pause_menu() -> void:
	print("4")
	get_tree().paused = true
	show()

func hide_pause_menu() -> void:
	get_tree().paused = false
	hide()

func toggle_pause() -> void:
	if get_tree().paused:
		hide_pause_menu()
	else:
		show_pause_menu()


func _on_continuar_pressed() -> void:
	print("2")
	hide_pause_menu()


func _on_sair_pressed() -> void:
	print("1")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/control.tscn") 
