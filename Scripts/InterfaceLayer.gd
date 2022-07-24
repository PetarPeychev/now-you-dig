extends CanvasLayer


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
		get_node("Equipment").visible = not get_node("Equipment").visible
		get_node("Inventory").visible = not get_node("Inventory").visible
