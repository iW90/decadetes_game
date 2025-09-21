class_name PositionTracker
extends ColorRect

var tracked_positions: Dictionary = {}  # { node: Vector2 }

func _ready() -> void:
	queue_redraw()

# Called by units when they spawn
func register_unit(unit: Node) -> void:
	if not unit.has_signal("map_position"):
		push_warning("Tried to register %s without 'map_position' signal" % unit.name)
		return
	if unit in tracked_positions:
		return
	tracked_positions[unit] = Vector2.ZERO
	unit.map_position.connect(_on_unit_position_updated.bind(unit))
	unit.tree_exited.connect(_on_unit_removed.bind(unit))

func _on_unit_position_updated(pos: Vector2, unit: Node) -> void:
	tracked_positions[unit] = pos
	queue_redraw()

func _on_unit_removed(unit: Node) -> void:
	tracked_positions.erase(unit)
	queue_redraw()

func _draw() -> void:
	var world_size = Vector2(9500, 7000) # replace with actual map size
	var minimap_size = size
	var offset = Vector2(130, 95)

	for unit in tracked_positions.keys():
		var pos = tracked_positions[unit]
		var minimap_pos = (pos / world_size) * minimap_size + offset
		var draw_color = Color.BLUE if unit.is_in_group("player") else Color.RED
		draw_circle(minimap_pos, 4, draw_color)
