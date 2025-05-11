extends PathFollow2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
#<<<<<<< Updated upstream
	#
	#if goblin.action == 0:
		#if progress_ratio == 1 or progress_ratio == 0:
			#going_back = !going_back
		#if going_back:
			#progress -= 25 * delta
		#else:
			#progress +=25 * delta
		#
		#
#=======
	#if $goblin.action = 0
	#progress += 4 * delta
#>>>>>>> Stashed changes
