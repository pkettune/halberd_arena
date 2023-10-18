class_name Enemy
extends CharacterBody2D

var enemy = self

@onready var player = get_node("/root/Main/Player/")
@onready var animation_player = $AnimationPlayer

@export var speed = 100
@export var health = 6

var knockback : Vector2 = Vector2.ZERO
var knockbackTween

func _physics_process(_delta):

	var player_position = player.position
	var target_position = (player_position - enemy.position).normalized()
	
	if enemy.position.distance_to(player_position) >= 30:
		velocity = Vector2(target_position * speed) + knockback
		look_at(player_position)
		move_and_slide()

func take_damage(_damage: int, knockback_strength : Vector2, stop_time : float = 0.4) -> void:
	
	health -= _damage
	
	if (knockback_strength != Vector2.ZERO):
		knockback = -knockback_strength * 6
		knockbackTween = get_tree().create_tween()
		knockbackTween.parallel().tween_property(self, "knockback", Vector2.ZERO, stop_time)
	if health <= 0:
		speed = 0
		animation_player.play("hurt")
		await get_tree().create_timer(0.3).timeout
		queue_free()
	
	$Sprite2D.scale.x = 0.29
	$Sprite2D.scale.y = 0.29
	await get_tree().create_timer(0.25).timeout
	$Sprite2D.scale.x = 0.34
	$Sprite2D.scale.y = 0.34	

