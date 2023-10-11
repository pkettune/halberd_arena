# Allows its owner to detect hits and take damage
class_name HurtBox
extends Area2D


#func _init() -> void:
# hurtbox should tecets hits but not deal them. This variable does that.
#	monitorable = false
# This turns off collision layer  bit 1 and turns on bit 32 = layer 6.
#	collision_mask = 32

#func _ready() -> void:
#	area_entered.connect(_on_area_entered)

func _on_area_entered(hitbox: HBox) -> void:
	if hitbox == null:
		return

	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
		print("damage")


