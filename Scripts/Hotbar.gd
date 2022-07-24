extends Control


var slots = Array()
var item_offset = Vector2(0, 0);


func _ready():
	for slot in get_tree().get_nodes_in_group("HotbarSlots"):
		slot.connect("gui_input", self, "slot_gui_input", [slot])
		slots.append(slot)
	
	var pickaxe = Item.new(ItemDatabase.get_item("Pickaxe"), slots[0], 1)
	slots[0].set_item(pickaxe)
	var torches = Item.new(ItemDatabase.get_item("Torch"), slots[1], 20)
	slots[1].set_item(torches)
	var helmet = Item.new(ItemDatabase.get_item("Iron Helmet"), slots[2], 1)
	slots[2].set_item(helmet)
	var chest = Item.new(ItemDatabase.get_item("Iron Chestplate"), slots[3], 1)
	slots[3].set_item(chest)
	var legs = Item.new(ItemDatabase.get_item("Iron Leggings"), slots[4], 1)
	slots[4].set_item(legs)
	var boots = Item.new(ItemDatabase.get_item("Iron Boots"), slots[5], 1)
	slots[5].set_item(boots)


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
