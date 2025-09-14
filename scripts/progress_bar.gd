extends ProgressBar

var progress: int = 100 : set = _set_progress
@onready var echo_bar: ProgressBar = $EchoBar
@onready var computer_screen: ColorRect = %ComputerScreen


func _set_progress(new_progress) -> void:
	value += new_progress

func _on_computer_screen_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		_set_progress(1)

func _on_timer_timeout() -> void:
	if value > 0:
		_set_progress(-5)
	else:
		computer_screen.color.a = 255
		computer_screen.get_child(0).show()
		computer_screen.mouse_filter = MOUSE_FILTER_IGNORE
