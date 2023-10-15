# Allows its owner to detect hits and take damage
class_name HurtBox
extends Area2D

func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox == null:
		return

	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
		print("damage")

