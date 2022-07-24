extends Node

signal player_initialised
signal debug_overlay_initialised

var player
var held_item = null

var debug_overlay


func _process(delta):
	if not player:
		initialise_player()
		
	if not debug_overlay:
		initialise_debug_overlay()
		

func initialise_player():
	if get_tree().get_root().has_node("Main/WorldLayer/Player"):
		player = get_tree().get_root().get_node("Main/WorldLayer/Player")
	if not player:
		return
		
	emit_signal("player_initialised", player)
	
#	player.inventory.connect("inventory_changed", self, "_on_player_inventory_changed")
	
#	var existing_inventory = load("user://inventory.tres")
#	if existing_inventory:
#		player.inventory.set_items(existing_inventory.get_items())
#	else:
#		# Starting Items
#		player.inventory.add_item("Pickaxe", 1)

func _on_player_inventory_changed(inventory):
# warning-ignore:return_value_discarded
	ResourceSaver.save("user://inventory.tres", inventory)
	
	
func initialise_debug_overlay():
	if get_tree().get_root().has_node("Main/DebugOverlay"):
		debug_overlay = get_tree().get_root().get_node("Main/DebugOverlay")
	if not debug_overlay:
		return
		
	emit_signal("debug_overlay_initialised", debug_overlay)
