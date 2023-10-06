class_name Enemy
extends CharacterBody2D

var enemy = self
@onready var player = get_parent().get_node("Player")
@onready var animation := $AnimatedSprite2D

@export var speed = 100
var player_position
var target_position

func _physics_process(_delta):
	
	player_position = player.position
	target_position = (player_position - enemy.position).normalized()
	
	if enemy.position.distance_to(player_position) >= 0.5:
		velocity = Vector2(target_position * speed) 
		look_at(player_position)
		move_and_slide()

func _on_area_entered(area):
	animation.play("hurt")
