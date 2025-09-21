extends ProgressBar

@onready var damage_bar: ProgressBar = $DamageBar
@onready var timer: Timer = $Timer

signal defeated

var health: int = 0 : set = set_health
var active: bool = true

func set_health(new_health) -> void:
	if not active: return
	var previous_health: int = health
	health = min(max_value, new_health)
	if health <= 0:
		active = false
		defeated.emit()
	value = health
	if health < previous_health:
		timer.start()
	else:
		damage_bar.value = health

func init(starting_health: int) -> void:
	health = starting_health
	max_value = health
	value = health
	damage_bar.max_value = health
	damage_bar.value = health


func _on_timer_timeout() -> void:
	damage_bar.value = health
