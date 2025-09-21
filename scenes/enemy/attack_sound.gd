extends AudioStreamPlayer2D

var sword_sounds = [
	preload("res://assets/sound_effects/sword_attacks/sword.1.ogg"),
	preload("res://assets/sound_effects/sword_attacks/sword.2.ogg"),
	preload("res://assets/sound_effects/sword_attacks/sword.3.ogg"),
	preload("res://assets/sound_effects/sword_attacks/sword.4.ogg"),
	preload("res://assets/sound_effects/sword_attacks/sword.5.ogg")
]

func play_random_sword_sound():
	var random_index = randi() % sword_sounds.size()
	stream = sword_sounds[random_index]
	play()
