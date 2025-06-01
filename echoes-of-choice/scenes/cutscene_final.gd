extends Node2D

var cutscene_manager

func _ready() -> void:
	cutscene_manager = $Node2D


func start_cutscene():
	cutscene_manager.start_cutscene()
	
func positive_karma_intervention():
	cutscene_manager.positive_karma_intervention()
	
func negative_karma_intervention():
	cutscene_manager.negative_karma_intervention()
	
func show_scene():
	cutscene_manager.show_scene()
	
func move_karma_negativo():
	cutscene_manager.move_karma_negativo()

func stop_karma_negativo():
	cutscene_manager.stop_karma_negativo()

func hide_scene():
	cutscene_manager.hide_scene()
