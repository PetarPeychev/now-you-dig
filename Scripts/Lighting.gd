extends Sprite

export var AIR_DROPOFF = 0.10
export var SOLID_DROPOFF = 0.60

onready var player = get_parent().get_node("Player")
onready var tiles = get_parent().get_node("World/ForegroundTiles/TileMap")

var light_radius = 16
var light_values = []

var size = Vector2()
var size_in_tiles = Vector2()
var snap_step = 512
var initialised = false

func _ready():
	for x in range(67):
		light_values.append([])
		for y in range(40):
			light_values[x].append(0)
	set_size()
	
func init_block_lights():
	for x in range(light_values.size()):
		for y in range(light_values[x].size()):
			if tiles.get_cell(x, y) == 13:
				light_block(x, y, 1, 0)
	
func _process(delta):
	if not initialised:
		init_block_lights()
		initialised = true
	set_pos()
	set_shader_tiles()

func light_block(x, y, intensity, iteration):
	if intensity < 0.01:
		return

	light_values[x][y] = intensity

	var dropoff
	if tiles.get_cell(x, y) == -1 or tiles.get_cell(x, y) == 13:
		dropoff = 1.0 - AIR_DROPOFF
	else:
		dropoff = 1.0 - SOLID_DROPOFF

	for nx in range(x - 1, x + 2):
		for ny in range(y - 1, y + 2):
			if nx != x or ny != y:
				var dist = sqrt( (nx - x) * (nx - x) + (ny - y) * (ny - y) )
				var target_intensity = intensity * pow(dropoff, dist)
				if within_bounds(nx, ny) and light_values[nx][ny] < target_intensity:
					light_block(nx, ny, target_intensity, iteration + 1)


func set_size():
	size = get_viewport_rect().size + (Vector2(snap_step, snap_step) * 2)
	size *= player.get_node("Camera").zoom
	size.x = stepify(size.x, 128)
	size.y = stepify(size.y, 128)
	size_in_tiles.x = int(size.x / 64)
	size_in_tiles.y = int(size.y / 64)

	scale = size
	
func set_pos():
	var pos_x = stepify(player.position.x, snap_step) - size.x / 2
	var pos_y = stepify(player.position.y, snap_step) - size.y / 2
	position = Vector2(pos_x, pos_y)

func within_bounds(x, y):
	return (x < light_values.size() and
			x >= 0 and
			y < light_values[x].size() and
			y >= 0)

func set_shader_tiles():

	var start_x = int(position.x / 64)
	var start_y = int(position.y / 64)

	var region_tile_info = []

	for y in range(start_y, start_y + size_in_tiles.y):
		for x in range(start_x, start_x + size_in_tiles.x):
			if within_bounds(x, y):
				region_tile_info.append(light_values[x][y] * 255)
			else:
				region_tile_info.append(0)

	var img = Image.new()
	img.create_from_data(size_in_tiles.x, size_in_tiles.y, false, Image.FORMAT_L8, region_tile_info)

	var tex = ImageTexture.new()
	tex.create_from_image(img)
	material.set_shader_param("light_values", tex)
