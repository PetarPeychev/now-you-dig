extends KinematicBody2D
 
export var MOVE_SPEED = 300
export var JUMP_FORCE = 750
export var GRAVITY = 50
export var MAX_FALL_SPEED = 1000
export var MAX_HEALTH = 100
#export var SNAP_HEIGHT = 32
#export var FLOOR_MAX_ANGLE = deg2rad(89)

var health = MAX_HEALTH
var y_velo = 0
#var inventory_resource = load("res://Scripts/Inventory.gd")
#var inventory = inventory_resource.new()
#var snap_vector = Vector2.DOWN * SNAP_HEIGHT
#var jump_timer

signal player_dead
signal player_health_changed


func _process(delta: float) -> void:
	GameManager.debug_overlay.variables["Player Position"] = position
	GameManager.debug_overlay.variables["Player Health"] = health
	GameManager.debug_overlay.variables["Player Y Velocity"] = y_velo


func _physics_process(delta) -> void:
	var move_dir = 0
	if Input.is_action_pressed("walk_right"):
		$Sprite.play("walking")
		$Sprite.flip_h = false;
		move_dir = 1
	if Input.is_action_pressed("walk_left"):
		$Sprite.play("walking")
		$Sprite.flip_h = true;
		move_dir = -1
	if move_dir == 0:
		$Sprite.play("idle")
		
	var grounded = _is_on_floor()
	
#	move_and_slide_with_snap(Vector2(move_dir * MOVE_SPEED, y_velo), snap_vector, Vector2(0, -1), true, 4, FLOOR_MAX_ANGLE, true)
#	if move_dir != 0:
#		if test_move(transform, Vector2(move_dir, -40)):
#			print("hello")
#			move_and_slide_with_snap(Vector2(move_dir, -40), snap_vector, Vector2.UP, false, 4, FLOOR_MAX_ANGLE)
	y_velo = move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velo)).y
	
	if is_on_ceiling():
		y_velo = 0
	
	if not grounded and move_dir == 0:
		$Sprite.play("jumping")
	
	y_velo += GRAVITY
	if grounded and Input.is_action_just_pressed("jump"):
		y_velo = -JUMP_FORCE
#		snap_vector = Vector2.ZERO
#		if jump_timer == null:
#			jump_timer = Timer.new()
#			add_child(jump_timer)
#		jump_timer.wait_time = 0.5
#		jump_timer.connect("timeout", self, "_jump_timeout")
#		jump_timer.start()
		take_damage(1) # TODO: Remove
	if grounded and y_velo >= 5:
		y_velo = 5
	if y_velo > MAX_FALL_SPEED:
		y_velo = MAX_FALL_SPEED
		

#func _jump_timeout():
#	snap_vector = Vector2.DOWN * SNAP_HEIGHT


func _is_on_floor() -> bool:
	if get_node("RaycastCenter").get_collider() != null:
		return true
	if get_node("RaycastLeft").get_collider() != null:
		return true
	if get_node("RaycastRight").get_collider() != null:
		return true
	return false

func take_damage(damage: int) -> void:
	health -= min(health, damage)
	emit_signal("player_health_changed", health)
	if health == 0:
		die()
		

func heal(health: int) -> void:
	health += min(MAX_HEALTH - health, health)
	emit_signal("player_health_changed", health)
		

func die() -> void:
	emit_signal("player_dead", self)
