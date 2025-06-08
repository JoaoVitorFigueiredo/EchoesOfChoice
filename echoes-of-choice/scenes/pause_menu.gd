extends Control

@onready var main = $"../../"


func _on_continuar_pressed() -> void:
	main.pauseMenu()


func _on_recomeçar_pressed() -> void:
	var current_scene: String = Global.current_scene
	get_tree().change_scene_to_file(current_scene)

func _on_sair_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/control.tscn")
