extends CanvasLayer

@onready var wave_label: Label = %WaveLabel
@onready var score_label: Label = %ScoreLabel

func set_wave(wave:int) -> void:
	wave_label.text = "WAVE: %d" % wave

func set_score(score:int) -> void:
	score_label.text = "SCORE: %d" % score
