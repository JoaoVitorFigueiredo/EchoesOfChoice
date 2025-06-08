extends CharacterBody2D

var speed = 50
@export var health := 50
var max_health = 50

var action = 0 # 0 -> patrulha ; 1 -> perseguição ; 2 -> voltando pro lugar da patrulha
var player = null
var player_last_known_location = null
var curr_dir = null
var last_known_position 
var has_line_of_sight = false
var target_position= false

@export var attack_range := 40.0
@export var attack_damage := 10
@export var attack_cooldown := 1.0


@onready var anim = $AnimatedSprite2D

var can_attack := true

@onready var raycast = $RayCast2D

@onready var col_polygon = $vision_patrol/CollisionPolygon2D
@onready var visual_polygon = $vision_indicator


func _ready():
	visual_polygon.polygon = col_polygon.polygon
	visual_polygon.color = Color(1, 0, 0, 0.3)  
	
	health = max_health

var directions = [Vector2.DOWN, Vector2.LEFT, Vector2.UP, Vector2.RIGHT]
var direction_index = 0
@export var direction_change_interval := 2.0  # seconds between turns
var direction_timer := 0.0

func _physics_process(delta):
	match action:
		0:
			direction_timer += delta
			if direction_timer >= direction_change_interval:
				direction_timer = 0.0
				direction_index = (direction_index + 1) % directions.size()
				
				curr_dir = directions[direction_index]
				velocity = curr_dir * speed

			else:
				velocity = Vector2.ZERO
			

		1:
			chase()
			

		2:
			#velocity.x = 0
			#velocity.y = 0
			return_to_path(delta)
	move_and_slide()
	
	
	if velocity.length() > 0.1:
		var angle = velocity.angle()
		col_polygon.rotation = angle
		visual_polygon.rotation = angle


var last_position
var idle_time

func _process(delta):

	if action == 1:
		var start = Vector2.ZERO
		var end = raycast.target_position
	

	if last_position and position.distance_to(last_position) < 1.0 and action == 1:
		idle_time += delta
	else:
		idle_time = 0.0
		last_position = position


	if idle_time >= 8.0:
		print("chase ended")
		action = 3 
		

func _on_vision_patrol_body_entered(body: CharacterBody2D) -> void:
	player = body
	raycast.target_position = player.position - position
	raycast.force_raycast_update()
	
	if not raycast.is_colliding():
		print("Chasing")
		action = 1

func _on_vision_body_exited(body: Node2D) -> void:
	pass 
func play_animation(movement):
	if curr_dir == Vector2.RIGHT:
		anim.flip_h = false
	elif curr_dir == Vector2.LEFT:
		anim.flip_h = true

	if movement == 1:
		anim.play("walk")
	else:
		anim.play("idle")

func chase():
	var distance_to_player = position.distance_to(player.position)

	if distance_to_player > attack_range:
		raycast.target_position = player.position - position
		raycast.force_raycast_update()
		

		if not raycast.is_colliding():
			has_line_of_sight = true
			last_known_position = player.position
		else:
			has_line_of_sight = false
			
		if has_line_of_sight:
			target_position = player.position
		else:
			target_position = last_known_position

		var direction = (target_position - position).normalized()
		velocity = direction * speed  
		play_animation(1)
	
	elif can_attack:
		velocity = Vector2.ZERO
		move_and_slide()
		attack()
	
func attack():
	can_attack = false
	anim.play("attack")
	print("Goblin atacando!")
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.knife_slash, false)
	start_attack_cooldown()
	
	velocity.x = 0
	velocity.y = 0


	await anim.animation_finished

	if player and position.distance_to(player.position) <= attack_range:
		player.take_damage(attack_damage)

func start_attack_cooldown():
	print("iniciando timer 2/2")
	await get_tree().create_timer(attack_cooldown).timeout
	print("goblin pode atacar novamente")
	can_attack = true

func return_to_path(delta):
	pass
	"""
	var target_pos = path_follow.global_position
	var dir = (target_pos - position).normalized()
	velocity = dir * speed

	# Once close enough, resume patrolling
	if global_position.distance_to(target_pos) < 5:
		action = 0
	play_animation(1)
	"""

@onready var health_bar = $HealthBar

func take_damage(amount: int):
	health -= amount
	print("Goblin took", amount, "damage. Remaining health:", health)
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.hit_attack, false)
	health_bar.value = health * 100 / max_health
	

	if health <= 0:
		die()

func die():
	print("Goblin morreu")
	queue_free()
