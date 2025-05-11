extends CharacterBody2D

var curr_dir = "none"
var speed =200
var is_chased = false
var n_chased = 0

func player():
	pass

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "intro")

func _process(delta):
	if is_chased and n_chased == 0:
		is_chased = false
	elif !is_chased and n_chased > 0:
		is_chased = true

func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_up"):
		curr_dir = "right"
		play_animation(1)
		velocity.x = speed*.75
		velocity.y = -speed*.75
		
	elif Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_down"):
		curr_dir = "right"
		play_animation(1)
		velocity.x = speed*.75
		velocity.y = speed*.75
	
	elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_down"):
		curr_dir = "left"
		play_animation(1)
		velocity.x = -speed*.75
		velocity.y = speed*.75
		
	elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_up"):
		curr_dir = "left"
		play_animation(1)
		velocity.x = -speed*.75
		velocity.y = -speed*.75
		
	elif Input.is_action_pressed("ui_right"):
		curr_dir = "right"
		play_animation(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		curr_dir = "left"
		play_animation(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		play_animation(1)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):
		play_animation(1)
		velocity.x = 0
		velocity.y = -speed
	
	else:
		play_animation(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()


func play_animation(movement):
	var dir = curr_dir
	var anim =$AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("walk")
		elif movement == 0:
			anim.play("idle")
			
	else:
		anim.flip_h = true
		if movement == 1:
			anim.play("walk")
		elif movement == 0:
			anim.play("idle")
