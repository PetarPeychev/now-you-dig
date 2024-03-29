extends Node


enum SlotType {
	DEFAULT = 0,
	HEAD = 1,
	CHEST = 2,
	LEGS = 3,
	FEET = 4,
	RING = 5
}


var items = Array()

func _ready():
	var directory = Directory.new()
	directory.open("res://Resources/Items")
	directory.list_dir_begin()
	
	var filename = directory.get_next()
	while filename:
		if not directory.current_is_dir():
			items.append(load("res://Resources/Items/%s" % filename))
		filename = directory.get_next()
		
		
func get_item(item_name):
	for i in items:
		if i.name == item_name:
			return i
	return null
		
	
