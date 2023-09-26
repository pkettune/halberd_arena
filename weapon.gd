extends RigidBody2D

var elapsed = 0.0

func _physics_process(delta):

	if Input.is_action_pressed("melee"):
		elapsed += 20 * delta
		rotation = lerp_angle(0, 1.25, elapsed)

	elif Input.is_action_just_released("melee"):
		elapsed = 0.0
		rotation = 0


	if Input.is_action_pressed("throw"):
		elapsed += 10 * delta
		position = get_global_mouse_position()

func _on_weapon_hitbox_child_entered_tree(_node):
	pass # damagea
