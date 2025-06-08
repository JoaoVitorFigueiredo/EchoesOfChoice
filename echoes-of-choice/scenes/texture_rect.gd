extends TextureRect

func _ready():
	var timer = Timer.new()
	timer.wait_time = 5.0
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	add_child(timer)
	timer.start()

func _on_Timer_timeout():
	get_tree().change_scene_to_file("res://scenes/control.tscn")
