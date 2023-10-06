extends Node2D

@export var weapon: Node
@export var crosshair: Node
@export var speed: int = 200
@export var aim_radius: int = 120
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
	position += player_direction * speed * delta

	look_at(get_global_mouse_position())

	var look_vector = Vector2.ZERO
	look_vector.x = Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left")
	look_vector.y = Input.get_action_strength("aim_down") - Input.get_action_strength("aim_up")
	look_at(position + look_vector.normalized())
	
	var aim_direction = Vector2(aim_radius, 0)
	crosshair.position = aim_direction
	
