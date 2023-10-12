extends Node2D

@onready var weapon = $Weapon

@export var crosshair: Node
@export var speed: int = 150
@export var aim_radius: int = 100

var screen_size = Vector2.ZERO

var deadzone = 0.2
var health = 3

var look_vector = Vector2.ZERO


func _ready():
	
	screen_size = get_viewport_rect().size
	
	InputMap.action_set_deadzone("aim_up", deadzone)
	InputMap.action_set_deadzone("aim_down", deadzone)
	InputMap.action_set_deadzone("aim_left", deadzone)
	InputMap.action_set_deadzone("aim_right", deadzone)

	InputMap.action_set_deadzone("up", deadzone)
	InputMap.action_set_deadzone("down", deadzone)
	InputMap.action_set_deadzone("left", deadzone)
	InputMap.action_set_deadzone("right", deadzone)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("melee"):
#		look_vector.x = false
#		look_vector.y = false
		weapon.attack()

func _process(delta):
	var player_direction = Input.get_vector("left", "right", "up", "down")
	position += player_direction * speed * delta
	
	if Input.get_last_mouse_velocity():
		look_at(get_global_mouse_position())
	else:
		look_vector.x = Input.get_action_raw_strength("aim_right") - Input.get_action_raw_strength("aim_left")
		look_vector.y = Input.get_action_raw_strength("aim_down") - Input.get_action_raw_strength("aim_up")
		look_at(position + look_vector.normalized())
		

	
	crosshair.position = Vector2(aim_radius, 0)
	
	position.x = clamp(position.x, 57, 663)
	position.y = clamp(position.y, 62, 662)

func _on_player_hurt_box_body_entered(_body):
	print("oof")
	$PlayerBody/PlayerSprite.skew = 0.5
	await get_tree().create_timer(0.25).timeout
	$PlayerBody/PlayerSprite.skew = 0
	
	health -= 1
	if health == 0:
		speed = 0
		get_tree().paused = true
		$AudioStreamPlayer2D.play()
		await get_tree().create_timer(3.5).timeout
		get_tree().reload_current_scene()
		get_tree().paused = false
