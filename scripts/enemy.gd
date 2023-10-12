class_name Enemy
extends CharacterBody2D

var enemy = self
const player_scene: PackedScene = preload("res://scenes/player.tscn")

@onready var player = get_node("/root/Main/Player/")
@onready var animation := $AnimatedSprite2D

@export var speed = 100
@export var health = 6

func _physics_process(_delta):
	
	var player_position = player.position
	var target_position = (player_position - enemy.position).normalized()
	
	if enemy.position.distance_to(player_position) >= 30:
		velocity = Vector2(target_position * speed) 
		look_at(player_position)
		move_and_slide()

func take_damage(_damage: int) -> void:
	health -= _damage
	if health <= 0:
		collision_mask = 0
		speed = 0
		animation.play("hurt")
		await get_tree().create_timer(0.3).timeout
		queue_free()
	
	if _damage < 4:
		enemy.position = lerp(player.position, enemy.position, 1.6)
	
	$AnimatedSprite2D.scale.x = 0.18
	$AnimatedSprite2D.scale.y = 0.18
	await get_tree().create_timer(0.25).timeout
	$AnimatedSprite2D.scale.x = 0.20
	$AnimatedSprite2D.scale.y = 0.20	
