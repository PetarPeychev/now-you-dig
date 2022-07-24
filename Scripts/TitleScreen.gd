extends Control


onready var play_button = get_node("CenterContainer/VBoxContainer/CenterContainer/PlayButton")
onready var options_button = get_node("CenterContainer/VBoxContainer/CenterContainer2/OptionsButton")
onready var quit_button = get_node("CenterContainer/VBoxContainer/CenterContainer3/QuitButton")


func _ready() -> void:
	get_node("CenterContainer/VBoxContainer/CenterContainer/PlayButton").grab_focus()
	
	
func _physics_process(delta: float) -> void:
	if play_button and options_button and quit_button:
		play_button.modulate = Color(0.45, 0.3, 0.16, 1)
		options_button.modulate = Color(0.45, 0.3, 0.16, 1)
		quit_button.modulate = Color(0.45, 0.3, 0.16, 1)
	var focused_node = get_focus_owner()
	if focused_node:
		focused_node.modulate = Color(0.7, 0.4, 0.1, 1)


func _on_QuitButton_pressed() -> void:
	get_tree().quit()


func _on_PlayButton_pressed() -> void:
	get_tree().change_scene("res://Scenes/Main.tscn")
