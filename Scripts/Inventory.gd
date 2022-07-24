extends Control


var slots = Array()
var item_offset = Vector2(0, 0);


func _ready():
	for slot in get_tree().get_nodes_in_group("InventorySlots"):
		slot.connect("gui_input", self, "slot_gui_input", [slot])
		slots.append(slot)


func slot_gui_input(event : InputEvent, slot : ItemSlot):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if GameManager.held_item:
				if slot.item:
					var temp_item = slot.item
					slot.pick_item()
					temp_item.rect_global_position = event.global_position - item_offset
					slot.put_item(GameManager.held_item)
					GameManager.held_item = temp_item
				else:
					slot.put_item(GameManager.held_item)
					GameManager.held_item = null
			elif slot.item:
				GameManager.held_item = slot.item
				item_offset = event.global_position - GameManager.held_item.rect_global_position
				slot.pick_item()
				GameManager.held_item.rect_global_position = event.global_position - item_offset


func _input(event : InputEvent):
	if GameManager.held_item && GameManager.held_item.picked && event is InputEventMouseMotion:
		GameManager.held_item.rect_global_position = event.position - item_offset
