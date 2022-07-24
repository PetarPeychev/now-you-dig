extends MarginContainer


var heart_full = preload("res://Assets/heart-full.png")
var heart_empty = preload("res://Assets/heart-empty.png")
var heart_partial = preload("res://Assets/heart-partial.png")


func _ready():
	GameManager.connect("player_initialised", self, "_on_player_initialised")


func _on_player_initialised(player) -> void:
	_update_health(player.health)


func _on_Player_player_health_changed(health: int) -> void:
	_update_health(health)


func _update_health(health: int) -> void:
	get_node("Bar/HealthHint").text = " HP: " + str(health) + " / " + str(GameManager.player.MAX_HEALTH)
	var remaining_health = health
	for heart in get_tree().get_nodes_in_group("Hearts"):
		if remaining_health >= 10:
			heart.texture = heart_full
			remaining_health -= 10
		elif remaining_health >= 1:
			heart.texture = heart_partial
			remaining_health = 0
		else:
			heart.texture = heart_empty


func _on_Health_mouse_entered() -> void:
	get_node("Bar/HealthHint").visible = true


func _on_Health_mouse_exited() -> void:
	get_node("Bar/HealthHint").visible = false
