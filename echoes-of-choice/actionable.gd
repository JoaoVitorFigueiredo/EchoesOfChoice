extends Area2D


@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "intro"
@export var auto_start: bool = true



func action():
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
	
			
func start_dialogue():
	DialogueManager.start(dialogue_start)
