extends Control

@onready var main = $"../../"


func _on_continuar_pressed() -> void:
	main.pauseMenu()

func _on_sair_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/control.tscn")
