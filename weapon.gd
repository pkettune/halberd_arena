extends CharacterBody2D

var elapsed = 0.0
var speed = 300

func _physics_process(delta):

	if Input.is_action_pressed("melee"):
		position = Vector2.ZERO
		elapsed +=  delta * 20
		rotation = lerp_angle(0, 1.25, elapsed)

	elif Input.is_action_just_released("melee"):
		elapsed = 0.0
		rotation = 0

	if Input.is_action_pressed("throw"):
		elapsed += delta * 1
		rotation_degrees = 45
		position = lerp(Vector2(0, 0), Vector2(-50, 0), elapsed)
	
	if Input.is_action_just_released("throw"):
		elapsed = 15 * delta
		
		var collision_info = move_and_collide(velocity.normalized() * delta * speed)
		
#		position = lerp(Vector2.ZERO, Vector2(500, 0), elapsed)
#		$WeaponSprite.look_at(get_global_mouse_position())
#		var collision_info = move_and_collide(velocity.normalized() * delta * speed)
