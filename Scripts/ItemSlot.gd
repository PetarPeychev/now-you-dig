extends TextureRect
class_name ItemSlot


export(ItemDatabase.SlotType) var slot_type = ItemDatabase.SlotType.DEFAULT

var item = null;

func _init():
	mouse_filter = Control.MOUSE_FILTER_PASS

func set_item(new_item):
	add_child(new_item)
	item = new_item
	item.item_slot = self

func pick_item():
	item.pick_item()
	remove_child(item)
	get_tree().get_root().get_node("Main/InterfaceLayer").add_child(item)
	item = null

func put_item(new_item):
	item = new_item
	item.item_slot = self
	item.put_item()
	get_tree().get_root().get_node("Main/InterfaceLayer").remove_child(item)
	add_child(item)

func remove_item():
	remove_child(item)
	item = null
