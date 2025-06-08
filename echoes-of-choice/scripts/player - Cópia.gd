extends CharacterBody2D

var curr_dir = "none"
var speed =200
var is_chased = false
var n_chased = 0

<<<<<<< Updated upstream
func _process(delta):
=======



var speed 

@onready var karma_bar = $Camera2D/CanvasLayer/KarmaBar


@export var knife_damage := 10
@onready var knife_area = $knife_area
@onready var animation_player = $AnimatedSprite2D
@onready var actionable_finder: Area2D = $Direction/dialogue
@onready var health_bar = $Camera2D/CanvasLayer/HealthBar

func _ready():
	knife_area.area_entered.connect(_on_knife_hit)
	knife_area.monitoring = false
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.walk_sound, true)
	animation_player.animation_finished.connect(_on_animation_finished)
	health_bar.value = PlayerVars.health

var is_attacking = false
	
		
@onready var pause_menu = $Camera2D/PauseMenu
var paused = false

func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused

func attack():
	if is_attacking:
		return
	is_attacking = true
	velocity = Vector2.ZERO
	knife_area.monitoring = true
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.knife_slash, false)
	animation_player.play("attack")

func _on_knife_hit(area: Area2D):
	if area.is_in_group("enemies"):
		
		var enemy_hit = area.get_parent()
		if enemy_hit.player == null:
			enemy_hit.take_damage(knife_damage*3)
		else:
			enemy_hit.take_damage(knife_damage)



func _on_animation_finished():
	if animation_player.animation == "attack":
		knife_area.monitoring = false
		is_attacking = false

func take_damage(amount: int):
	PlayerVars.health -= amount
	print("Jogador levou", amount, "de dano. Vida restante:", PlayerVars.health)
	health_bar.value = PlayerVars.health * 100 / PlayerVars.max_health
	if PlayerVars.health <= 0:
		die()

func die():
	print("Jogador morreu")
	

func player():
	pass

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			return

func _process(delta):
	karma_bar.value = PlayerVars.karma
	if Input.is_action_just_pressed("pause"):
			pauseMenu()
	
>>>>>>> Stashed changes
	if is_chased and n_chased == 0:
		is_chased = false
	elif !is_chased and n_chased > 0:
		is_chased = true

func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
<<<<<<< Updated upstream
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_up"):
		curr_dir = "right"
		play_animation(1)
		velocity.x = speed*.75
		velocity.y = -speed*.75
=======
	if not is_attacking and PlayerVars.can_move:
		if Input.is_action_pressed("move_right") and Input.is_action_pressed("move_up"):
			curr_dir = "right"
			play_animation(1)
			velocity.x = speed*.75
			velocity.y = -speed*.75
			
		elif Input.is_action_pressed("move_right") and Input.is_action_pressed("move_down"):
			curr_dir = "right"
			play_animation(1)
			velocity.x = speed*.75
			velocity.y = speed*.75
>>>>>>> Stashed changes
		
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
