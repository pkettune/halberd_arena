class_name Enemy
extends CharacterBody2D

var enemy = self

@export var player_scene: PackedScene = preload("res://scenes/player.tscn")

@onready var player = get_node("/root/Main/Player/")
@onready var animation := $AnimatedSprite2D
#@onready var dying_text := $DyingText

@export var speed = 100
@export var health = 7

func _physics_process(_delta):
	
	var player_position = player.position
	var target_position = (player_position - enemy.position).normalized()
	
	if enemy.position.distance_to(player_position) >= 30:
		velocity = Vector2(target_position * speed) 
		look_at(player_position)
		move_and_slide()

func _on_area_entered(area):
	health -= 1

	if health <= 0:
		animation.play("hurt")
		await get_tree().create_timer(0.2).timeout
		queue_free()
