extends Node2D

var sound_effect_dict: Dictionary = {} ## Loads all registered SoundEffects on ready as a reference.

@export var sound_effects: Array[SoundEffect]

# Guarda o player atualmente ativo para controlo
var current_audio_player: AudioStreamPlayer = null


func _ready() -> void:
	for sound_effect: SoundEffect in sound_effects:
		sound_effect_dict[sound_effect.type] = sound_effect


func create_2d_audio_at_location(location: Vector2, type: SoundEffect.SOUND_EFFECT_TYPE) -> void:
	if sound_effect_dict.has(type):
		var sound_effect: SoundEffect = sound_effect_dict[type]
		if sound_effect.has_open_limit():
			sound_effect.change_audio_count(1)
			var new_2D_audio: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
			add_child(new_2D_audio)
			new_2D_audio.position = location
			new_2D_audio.stream = sound_effect.sound_effect
			new_2D_audio.volume_db = sound_effect.volume
			new_2D_audio.pitch_scale = sound_effect.pitch_scale
			new_2D_audio.pitch_scale += Global.rng.randf_range(-sound_effect.pitch_randomness, sound_effect.pitch_randomness )
			new_2D_audio.finished.connect(sound_effect.on_audio_finished)
			new_2D_audio.finished.connect(new_2D_audio.queue_free)
			new_2D_audio.play()
	else:
		push_error("Audio Manager failed to find setting for type ", type)

func create_audio(type: SoundEffect.SOUND_EFFECT_TYPE, loop := false) -> AudioStreamPlayer:
	if sound_effect_dict.has(type):
		var sound_effect: SoundEffect = sound_effect_dict[type]
		if sound_effect.has_open_limit():
			sound_effect.change_audio_count(1)
			var new_audio: AudioStreamPlayer = AudioStreamPlayer.new()
			add_child(new_audio)

			var stream = sound_effect.sound_effect.duplicate()
			if stream is AudioStream:
				stream.loop = loop
			new_audio.stream = stream

			new_audio.volume_db = sound_effect.volume
			new_audio.pitch_scale = sound_effect.pitch_scale

			var rng := RandomNumberGenerator.new()
			rng.randomize()
			new_audio.pitch_scale += rng.randf_range(-sound_effect.pitch_randomness, sound_effect.pitch_randomness)

			if not loop:
				new_audio.finished.connect(sound_effect.on_audio_finished)
				new_audio.finished.connect(new_audio.queue_free)

			new_audio.play()
			
			current_audio_player = new_audio
			return new_audio
		else:
			# Limite atingido, não cria áudioa
			return null
	else:
		push_error("Audio Manager failed to find setting for type ", type)
		return null



func stop():
	if current_audio_player:
		current_audio_player.stop()
		current_audio_player.queue_free()
		current_audio_player = null

	
