class_name HBox
extends Area2D

@export var damage := 3

@onready var collision_shape := $CollisionShape2D

func set_disabled(is_disabled: bool) -> void:
	collision_shape.set_deferred("disabled", is_disabled)
