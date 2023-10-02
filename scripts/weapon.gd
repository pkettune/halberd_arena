extends CharacterBody2D

@onready var anim_player = $AnimationPlayer

var elapsed = 0.0
var speed = 300

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
		
	if Input.is_action_pressed("throw"):
		anim_player.speed_scale = 1
		anim_player.play("power_up")

		var power_up_speed = 0.8
		rotation_degrees = 45
		elapsed += delta * 1
		position = lerp(Vector2(0, 0), Vector2(-50, 0), elapsed * power_up_speed)
		if (position < Vector2(-25.0, 0.0)):
			position = Vector2(-25.0, 0.0)
			_on_animation_player_animation_finished("power_up")
		
	if Input.is_action_just_released("throw"):
		pass


func _on_animation_player_animation_finished(anim_name):
	anim_player.speed_scale = 0
	#####PPLLAAAYYYYY SOUUUND ZING!
	#####FUlL POWER !!!!!!!!

	

	
	
#func throw(int):
#
#
#	var collision_info = move_and_collide(velocity.normalized() * delta * speed)
#
#	position = lerp(Vector2.ZERO, Vector2(500, 0), elapsed)
#	$WeaponSprite.look_at(get_global_mouse_position())
#	var collision_info = move_and_collide(velocity.normalized() * delta * speed)
#

