extends Node2D

@onready var anim_player = $AnimationPlayer


var elapsed = 0.0
var speed = 300
var throw_speed = 1
var power_up_speed = 0.8

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

		rotation_degrees = 45
		elapsed += delta * 1
		position = lerp(Vector2(0, 0), Vector2(-50, 0), elapsed * power_up_speed)
		if position == Vector2(-26.0, 0.0):
			$AudioStreamPlayer2D.play()
		if (position <= Vector2(-26.0, 0.0)):
			position = Vector2(-25.0, 0.0)
			_on_animation_player_animation_finished("power_up")
			
			
	if Input.is_action_just_released("throw"):
		var tween = create_tween()
		for sprite in get_children():
			tween.tween_property(sprite, "position", get_local_mouse_position(), 0.1)
			tween.tween_property(sprite, "position", Vector2.ZERO, 0.1)
#		position = Vector2.ZERO
#		elapsed += delta * 0.1
#		position = lerp(Vector2(0, 0), Vector2(200.0, 0.0), elapsed * delta)
		print(position)

func _on_animation_player_animation_finished(anim_name):
	anim_player.speed_scale = 0
