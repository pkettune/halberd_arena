class_name Enemy
extends CharacterBody2D

@onready var animation := $AnimatedSprite2D

var enemy = self

@export var player_scene: PackedScene = preload("res://scenes/player.tscn")
@onready var player = get_node("/root/Main/Player/")


@export var speed = 100
@export var health = 10

func _physics_process(_delta):
	
	var player_position = player.position
	var target_position = (player_position - enemy.position).normalized()
	
	if enemy.position.distance_to(player_position) >= 30:
		velocity = Vector2(target_position * speed) 
		look_at(player_position)
		move_and_slide()

func _on_area_entered(area):
	animation.play("hurt")
	health -= 1

	if health <= 0:
		queue_free()
