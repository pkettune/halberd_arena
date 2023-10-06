class_name Weapon
extends Node2D

@onready var anim_player = $AnimationPlayer


var elapsed = 0.0
var speed = 300
var throw_speed = 1
var power_up_speed = 1.5

func _ready():
	position = Vector2.ZERO

func _physics_process(delta):

	if Input.is_action_pressed("melee"):
		anim_player.stop()
		position = Vector2.ZERO
		elapsed +=  delta * 20
		rotation = lerp_angle(0, 1.25, elapsed)

	elif Input.is_action_just_released("melee"):
		anim_player.stop()
		elapsed = 0.0
		rotation = 0
		
	if Input.is_action_just_pressed("throw"):
		position = Vector2.ZERO

	if Input.is_action_pressed("throw"):
		anim_player.speed_scale = 1
		anim_player.play("power_up")
		
		elapsed += delta * 1
		rotation_degrees = 45
		
		position = lerp(Vector2(1, 0), Vector2(-25, 0), elapsed * power_up_speed)
		if position == Vector2(-25.0, 0.0):
			$AudioStreamPlayer2D.play()
		if (position <= Vector2(-25.0, 0.0)):
			position = Vector2(-27.0, -0.5)
			_on_animation_player_animation_finished("power_up")


func _on_animation_player_animation_finished(_anim_name):
	anim_player.speed_scale = 0
