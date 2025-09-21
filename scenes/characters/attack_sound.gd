extends AudioStreamPlayer2D

var sword_sounds = [
	preload("res://assets/sound_effects/sword_attacks/sword.6.ogg"),
	preload("res://assets/sound_effects/sword_attacks/sword.7.ogg"),
	preload("res://assets/sound_effects/sword_attacks/sword.8.ogg"),
	preload("res://assets/sound_effects/sword_attacks/sword.9.ogg"),
	preload("res://assets/sound_effects/sword_attacks/sword.10.ogg")
]

func play_random_sword_sound():
	var random_index = randi() % sword_sounds.size()
	stream = sword_sounds[random_index]
	play()
