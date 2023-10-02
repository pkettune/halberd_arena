extends CharacterBody2D

var enemy = self
@onready var player = get_parent().get_node("Player")

@export var speed = 100
var player_position
var target_position

func _physics_process(_delta):
	
	player_position = player.position
	target_position = (player_position - enemy.position).normalized()
	
	if enemy.position.distance_to(player_position) > 1:
		velocity = Vector2(target_position * speed) 
		look_at(player_position)
		move_and_slide()
