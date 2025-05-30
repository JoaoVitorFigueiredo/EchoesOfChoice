extends Control

@onready var panel = $Panel
@onready var label = $Panel/Label
@onready var button = $Panel/Button

var is_visible: bool = false

func _ready():
	hide_panel()
	

func show_panel(text: String):
	label.text = text
	panel.visible = true
	is_visible = true

func hide_panel():
	panel.visible = false
	is_visible = false

func _on_button_pressed():
	print("Interação realizada!")
	hide_panel()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and is_visible:
		_on_button_pressed()
