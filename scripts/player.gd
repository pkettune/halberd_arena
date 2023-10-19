extends CharacterBody2D

@onready var weapon = $Weapon

@export var crosshair: Node
@export var speed: int = 150
@export var aim_radius: int = 100

var screen_size = Vector2.ZERO

var health = 3
var deadzone = 0.2

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
		weapon.attack()

func _process(delta):
	var player_direction = Input.get_vector("left", "right", "up", "down")
	position += player_direction * speed * delta
	
	if InputEventJoypadMotion:
		look_vector.x = Input.get_action_raw_strength("aim_right") - Input.get_action_raw_strength("aim_left")
		look_vector.y = Input.get_action_raw_strength("aim_down") - Input.get_action_raw_strength("aim_up")
		look_at(position + look_vector.normalized())

	crosshair.position = Vector2(aim_radius, 0)
	
	position.x = clamp(position.x, 57, 663)
	position.y = clamp(position.y, 62, 662)

func _physics_process(_delta):
	move_and_slide()

func _on_player_hurt_box_area_entered(_area):
	health -= 1
	print("oof")
	$PlayerSprite.skew = 0.5
	await get_tree().create_timer(0.25).timeout
	$PlayerSprite.skew = 0

	if health <= 0:
		speed = 0
		get_tree().paused = true
		$AudioStreamPlayer2D.play()
		await get_tree().create_timer(3.5).timeout
		get_tree().reload_current_scene()
		get_tree().paused = false
	


func _on_player_hurt_box_body_entered(body):
	if owner.has_method("take_damage"):
		owner.take_damage(1, body.velocity)
