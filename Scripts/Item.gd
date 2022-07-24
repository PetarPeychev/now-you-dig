extends TextureRect
class_name Item


var item_slot = null
var picked: bool = false
var item_resource = null
var quantity = 1
var quantity_label = null


func _init(_item_resource, _item_slot, _quantity) -> void:
	mouse_filter = Control.MOUSE_FILTER_PASS
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	item_resource = _item_resource
	item_slot = _item_slot
	quantity = _quantity
	texture = item_resource.texture
	
	quantity_label = Label.new()
	quantity_label.set("custom_fonts/font", load("res://Resources/PerfectFont.tres"))
	update_quantity(quantity)
	add_child(quantity_label)


func pick_item() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	picked = true
	
	
func put_item() -> void:
	rect_position = Vector2(0, 0);
	mouse_filter = Control.MOUSE_FILTER_PASS
	picked = false
	

func update_quantity(_quantity: int) -> void:
	quantity = _quantity
	quantity_label.text = str(quantity)
	quantity_label.set_position(Vector2(46 - ((str(quantity).length() - 1) * 12), 38))
	if quantity == 1:
		quantity_label.visible = false
	else:
		quantity_label.visible = true
