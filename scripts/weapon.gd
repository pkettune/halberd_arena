class_name Weapon
extends Node2D

const ProjectileScene := preload("res://scenes/projectile.tscn")

@onready var player = get_parent().get_parent().get_node("Player")
@onready var shoot_position = get_parent().get_node("ShootPosition")
@onready var anim_player = $AnimationPlayer

var elapsed = 0
var speed = 300
var throw_speed = 1
var power_up_speed = 1.5

func _ready():
	position = Vector2.ZERO
	
func attack():
	anim_player.play("attack")
	$Halberd/HitBox.collision_layer = 16
	await get_tree().create_timer(0.5).timeout
	$Halberd/HitBox.collision_layer = 0

func _physics_process(delta):
	if player.health == 0:
		set_physics_process(false)

	if Input.is_action_pressed("throw"):
		anim_player.speed_scale = 1.0
		anim_player.play("power_up")
		
		elapsed += delta * 1
		rotation_degrees = 45
		
		position = lerp(Vector2(1, 0), Vector2(-26, 0), elapsed * power_up_speed)
		if position == Vector2(-26.0, 0.0):
			$AudioStreamPlayer2D.play()
		if (position <= Vector2(-26.0, 0.0)):
			position = Vector2(-32.0, -0.0)

	if Input.is_action_just_released("throw"):
		position = Vector2.ZERO
		if anim_player.get_current_animation_position() >= 0.67:
			shoot(ProjectileScene)
		anim_player.stop()
		elapsed = 0.0
		rotation = 0

func shoot(projectile:PackedScene) -> void:
	var projectile_instance := projectile.instantiate()
	projectile_instance.position = shoot_position.global_position
	projectile_instance.direction = global_position.direction_to(projectile_instance.position)
	add_child(projectile_instance)
