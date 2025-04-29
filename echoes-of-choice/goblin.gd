extends CharacterBody2D

var speed = 50

var action = 2 # 0 -> patrulha ; 1 -> perseguição ; 2 -> voltando pro lugar da patrulha
var player = null
var player_last_known_location = null
var curr_dir = null
var last_known_position 
var has_line_of_sight = false
var target_position= false

@onready var raycast = $RayCast2D

@onready var col_polygon = $vision_patrol/CollisionPolygon2D
@onready var visual_polygon = $vision_indicator


func _ready():
	visual_polygon.polygon = col_polygon.polygon
	visual_polygon.color = Color(1, 0, 0, 0.3)  

func _physics_process(delta):
	
	match action:
		0:
			print(action)	
			velocity.x = 0
			velocity.y = 0
			

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

@onready var line = $Line2D
var last_position
var idle_time

func _process(delta):
	# draws the line
	if action == 1:
		var start = Vector2.ZERO
		var end = raycast.target_position
		line.points = [start, end]
	
	# Check if enemy moved
	if last_position and position.distance_to(last_position) < 1.0 and action == 1:
		idle_time += delta
	else:
		idle_time = 0.0
		last_position = position

	# Has it been idle for 8 seconds?
	if idle_time >= 8.0:
		print("chase ended")
		action = 3 # End the chase and return to patrol
		


func _on_vision_body_entered(body: Node2D) -> void:
	player = body
	raycast.target_position = player.position - position
	raycast.force_raycast_update()
	
	if not raycast.is_colliding():
		print("Chasing")
		action = 1

func _on_vision_body_exited(body: Node2D) -> void:
	pass # Replace with function body.

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
		anim.flip_h = false
		if movement == 1:
			anim.play("walk")
		elif movement == 0:
			anim.play("idle")

func chase():
	raycast.target_position = player.position - position
	raycast.force_raycast_update()
	
	# Check if there's a clear line of sight
	if not raycast.is_colliding():
		has_line_of_sight = true
		last_known_position = player.position
	else:
		has_line_of_sight = false
		
	if has_line_of_sight:
		target_position = player.position
	else:
		target_position = last_known_position
	# Decide where to move
	var direction = (target_position - position).normalized()
	velocity = direction * speed  # or whatever speed
	play_animation(1)

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
