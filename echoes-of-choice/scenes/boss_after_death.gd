extends CharacterBody2D

var speed = 50
@export var health := 50
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
@onready var attack_zone = $vision_indicator
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
		
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "final"
		
func _ready():
	health = 0
	print(dialogue_resource)
	if dialogue_resource:
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
	else:
		push_error("dialogue_resource não atribuído ao Goblin.")


func _physics_process(delta):
	if is_attacking:
		# Don't chase or move while attacking
		velocity = Vector2.ZERO
		move_and_slide()
		return

	move_and_slide()

	if velocity.length() > 0.1:
		var angle = velocity.angle()
		
