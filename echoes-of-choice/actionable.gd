extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "intro"
@export var auto_start: bool = true
@export var interaction_text: String = "Interagir"

@onready var key_label = $panel_botão

var player_nearby := false
var dialogue_active = false

func _ready():
	key_label.hide_panel()

func _on_body_entered(body):
	if body.has_method("player"):
		print("Player entrou na área!")
		key_label.show_panel(interaction_text)
		player_nearby = true

		
		
func _on_body_exited(body):
	if body.has_method("player"):
		key_label.hide_panel()
		player_nearby = false

func _process(delta):
	if player_nearby and Input.is_action_just_pressed("ui_accept"):
		if not dialogue_active:
			action()
			dialogue_active = true 
		else:
			pass

func action():
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
	
