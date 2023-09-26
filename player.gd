extends Node2D

@export var weapon: Node
#@export var crosshair: Node

@onready var crosshair = $Crosshair/CrosshairSprite

var player_direction: int = 0
var sens = 30
var aim_radius = 45
var deadzone = 0.2


func _ready():
	InputMap.action_set_deadzone("aim_up", deadzone)
	InputMap.action_set_deadzone("aim_down", deadzone)
	InputMap.action_set_deadzone("aim_left", deadzone)
	InputMap.action_set_deadzone("aim_right", deadzone)

	InputMap.action_set_deadzone("up", deadzone)
	InputMap.action_set_deadzone("down", deadzone)
	InputMap.action_set_deadzone("left", deadzone)
	InputMap.action_set_deadzone("right", deadzone)
	
func _physics_process(delta):
	var player_direction = Input.get_vector("left", "right", "up", "down")
	position += player_direction * 200 * delta

	look_at(get_global_mouse_position())
#	if (Input.mouse_mode):
#		Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
#		Input.warp_mouse(get_viewport().get_mouse_position() + aim_movement)
#	crosshair.position = self.get_local_mouse_position().normalized() * aim_radius
	
	var look_vector = Vector2.ZERO
	look_vector.x = Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left")
	look_vector.y = Input.get_action_strength("aim_down") - Input.get_action_strength("aim_up")
	look_at(position + look_vector.normalized())
	
	var aim_direction = Vector2(aim_radius, 0)
	crosshair.position = aim_direction * 2
	
	var aim_movement = sens * aim_direction





#	var aim_direction: Vector2
#	crosshair.position = (-self.position + get_local_mouse_position())
#	crosshair.position = self.get_local_mouse_position().normalized() * aim_radius
#
#	aim_direction.x = Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left")
#	aim_direction.y = Input.get_action_strength("aim_down") - Input.get_action_strength("aim_up")
#	aim_direction = aim_direction.normalized()
#
##	abs removes negative values so controller works properly
#	if abs(aim_direction.x) > 0 and abs(aim_direction.y) > 0:
#		var controllerangle = Vector2.ZERO
#		controllerangle = Vector2(aim_direction.x, aim_direction.y).angle()
#		crosshair.rotation = controllerangle
#
#	if abs(crosshair.position.y - self.position.y) <= 0.05 or abs(crosshair.position.x - self.position.x) <= 0.05:
#		crosshair.position = self.get_local_mouse_position().normalized() * aim_radius
#
#
#	var aim_movement = sens * aim_direction
#	if (aim_direction):
#		Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
#		Input.warp_mouse(get_viewport().get_mouse_position() + aim_movement)
#
