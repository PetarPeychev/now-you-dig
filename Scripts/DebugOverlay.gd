extends CanvasLayer


var variables = {}
onready var label = get_tree().get_root().get_node("Main/DebugOverlay/Label")


func _process(delta: float) -> void:
	variables["FPS"] = Engine.get_frames_per_second()
	
	if label:
		label.text = ""
		for key in variables.keys():
			label.text += key + ": " + str(variables[key]) + "\n"
		
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug"):
		label.visible = not label.visible
