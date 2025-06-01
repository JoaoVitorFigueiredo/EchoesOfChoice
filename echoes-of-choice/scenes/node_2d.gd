extends Node2D

@onready var boss = $Boss
@onready var boss_anim = $Boss/AnimatedSprite2D

@onready var player = $PlayerCutscene
@onready var player_anim = $PlayerCutscene/AnimatedSprite2D

@onready var k_positivo = $KarmaPositivo
@onready var k_positivo_anim = $KarmaPositivo/AnimatedSprite2D


@onready var k_negativo = $KarmaNegativo
@onready var k_negativo_anim = $KarmaNegativo/AnimatedSprite2D


@export var dialogue_resource: DialogueResource = preload("res://dialogos/final.dialogue")
@export var dialogue_start: String = ""

@onready var anim_player = $AnimationPlayer

@onready var black_screen = $ColorRect

	

func _ready():
	boss_anim.play("idle")
	k_negativo_anim.play("idle")
	k_positivo_anim.play("idle")
	player_anim.play("idle")
	
	CutsceneFinal.cutscene_manager = self

	if anim_player:
		anim_player.play("fadeout")
		await anim_player.animation_finished
		start_cutscene()
	else:
		push_error("AnimationPlayer não encontrado.")


		

func start_cutscene():
	print(dialogue_resource)
	if dialogue_resource:
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
	else:
		push_error("dialogue_resource não atribuído ao Goblin.")

func positive_karma_intervention() -> void:
	# Anda para frente
	var move_duration := 1  # tempo em segundos
	var move_direction := Vector2.RIGHT  # ou LEFT se quiser inverter
	var start_position = player.position
	player_anim.play("walk")
	var elapsed := 0.0
	
	while elapsed < move_duration:
		player.velocity = move_direction * 50  # ajuste a velocidade conforme necessário
		player.move_and_slide()
		await get_tree().process_frame
		elapsed += get_process_delta_time()

	# Para de andar
	player.velocity = Vector2.ZERO
	player.move_and_slide()
	player_anim.play("attack")

	# Espera até a animação de ataque terminar
	await player_anim.animation_finished
	
	anim_player.play("fadein")
	await anim_player.animation_finished
	player.position = start_position
	k_positivo_anim.visible = true
	
	# Mostra o diálogo
	start_redemption_dialogue()

func start_redemption_dialogue():
	dialogue_resource = preload("res://dialogos/dialogue_kill_goblin.dialogue")
	if dialogue_resource:
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
	else:
		push_error("dialogue_resource não atribuído ao Goblin.")
	
func negative_karma_intervention():
	var move_duration := 1  # tempo em segundos
	var move_direction := Vector2.LEFT  # ou LEFT se quiser inverter
	var start_position = boss.position
	boss_anim.play("walk")
	player_anim.flip_h = true
	player_anim.play("walk")
	var elapsed := 0.0
	
	while elapsed < move_duration:
		boss.velocity = move_direction * 50  # ajuste a velocidade conforme necessário
		player.velocity = move_direction * 45
		
		boss.move_and_slide()
		player.move_and_slide()
		await get_tree().process_frame
		elapsed += get_process_delta_time()
	
	
	# Para de andar
	
	boss.velocity = Vector2.ZERO
	boss.move_and_slide()
	boss_anim.play("attack")

	# Espera até a animação de ataque terminar
	await boss_anim.animation_finished
	player.velocity = Vector2.ZERO
	player.move_and_slide()
	
	player_anim.play("idle")
	anim_player.play("fadein")
	await anim_player.animation_finished
	player_anim.flip_h = false
	boss.position = start_position
	k_negativo_anim.visible = true

	dialogue_resource =  preload("res://dialogos/dialogue_spare_goblin.dialogue")
	if dialogue_resource:
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
	else:
		push_error("dialogue_resource não atribuído ao Goblin.")
		

func show_scene():
	anim_player.play("fadeout")
	
func hide_scene():
	anim_player.play("fadein")
	
func move_karma_negativo():
	var move_direction := Vector2.LEFT  # ou LEFT se quiser inverter
	k_negativo_anim.flip_h = true
	k_negativo.velocity = move_direction * 15
	var move_duration := 0.5
	var elapsed := 0.0
	while elapsed<move_duration:
		k_negativo.move_and_slide()
		await get_tree().process_frame
		elapsed += get_process_delta_time()
	
		
func stop_karma_negativo():
	k_negativo.velocity = Vector2.ZERO
