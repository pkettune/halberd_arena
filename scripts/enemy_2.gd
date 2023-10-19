extends "res://scripts/enemy.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func take_damage(_damage: int, knockback_strength : Vector2, stop_time : float = 0.4) -> void:
	if _damage < 4:
		_damage = 0
		
	health -= _damage
	
	if (knockback_strength != Vector2.ZERO):
		knockback = -knockback_strength * 2
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
