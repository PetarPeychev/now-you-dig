extends Camera2D


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_out"):
		zoom += Vector2(0.1, 0.1)
	if event.is_action_pressed("zoom_in"):
		zoom -= Vector2(0.1, 0.1)
