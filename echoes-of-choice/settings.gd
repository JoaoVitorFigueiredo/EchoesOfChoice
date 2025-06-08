extends Control

var center: Vector2
@onready var node := $Settings
@onready var button_voltar: Button = $VBoxContainer/Voltar
@onready var slider_volume: HSlider = $VBoxContainer/VolumeSlider
var tween: Tween

func _ready():
	update_center()

	button_voltar.pressed.connect(voltar)
	slider_volume.value_changed.connect(on_volume_changed)

	get_viewport().size_changed.connect(update_center)
	load_settings()

func _process(_delta):
	if not tween or not tween.is_running():
		var offset = center - get_global_mouse_position() * 0.1
		if tween:
			tween.kill() 
		tween = create_tween()
		tween.tween_property(node, "position", offset, 1.0)


func update_center():
	center = get_viewport_rect().size / 2
	if node:
		node.global_position = center

func voltar():
	save_settings()
	get_tree().change_scene_to_file("res://scenes/control.tscn")

func on_volume_changed(value):
	print("Volume ajustado para:", value)
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Master"),
		linear_to_db(value / 100.0)
	)


func save_settings():
	var config = ConfigFile.new()
	config.set_value("audio", "volume", slider_volume.value)
	config.save("user://settings.cfg")

func load_settings():
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err == OK:
		slider_volume.value = config.get_value("audio", "volume", 50)
