extends CharacterBody2D

var speed = 50
@export var health := 100
var max_health = 100

var idle_time

@onready var player = get_parent().get_node("player")
var player_last_known_location = null
var curr_dir = null
var last_known_position 
var has_line_of_sight = false
var target_position= false

@export var attack_range := 60.0
@export var attack_damage := 50
@export var attack_cooldown := 1.0



var is_attacking = false


@onready var anim = $AnimatedSprite2D

var can_attack := true

@onready var raycast = $RayCast2D
@onready var first_attack_hit = $FirstAtack/CollisionShape2D
@onready var attack_zone = $vision_indicator
@onready var hit_checker = $FirstAtack

@onready var health_bar = $HealthBar

func play_animation(movement):
	if velocity.x > 0:
		anim.flip_h = false  # Moving right
	elif velocity.x < 0:
		anim.flip_h = true   # Moving left
	
	if movement == 1:
		anim.play("walk")
	else:
		anim.play("idle")

func chase():
	
	var distance_to_player = position.distance_to(player.position)
	if distance_to_player <= attack_range:
		velocity = Vector2.ZERO
		if can_attack:
			attack()
		
	else:
		target_position = player.position
		# Decide where to move
		var direction = (target_position - position).normalized()
		velocity = direction * speed  # or whatever speed
		play_animation(1)
	
	
		
		
func _ready():
	attack_zone.polygon = first_attack_hit.shape.points
	attack_zone.visible = false 
	
	health = max_health


func _physics_process(delta):
	if is_attacking:
		# Don't chase or move while attacking
		velocity = Vector2.ZERO
		move_and_slide()
		return

	chase()
	move_and_slide()

	if velocity.length() > 0.1:
		var angle = velocity.angle()
		first_attack_hit.rotation = angle
		attack_zone.rotation = angle
		


func attack():
	attack_zone.color = Color(0.1, .1, .1, 0.3) 
	attack_zone.visible = true 
	if is_attacking:
		return
	is_attacking = true
	anim.play("attack")

func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.animation == "attack":
		attack_zone.color = Color(1, 0, 0, 0.3) 
		
		if player and hit_checker.get_overlapping_bodies().has(player):
			player.take_damage(attack_damage)
		is_attacking = false
		attack_zone.visible = false
		target_position = player.position
		# Decide where to move
		var direction = (target_position - position).normalized()
		velocity = direction * 0.1  # or whatever speed
		var angle = velocity.angle()
		first_attack_hit.rotation = angle
		attack_zone.rotation = angle
		

func take_damage(damage):
	health -= damage
	health_bar.value = health*100/max_health
	if health <= 0:
		die()


func die():
	get_tree().change_scene_to_file("res://scenes/cutscene_final.tscn")
	
