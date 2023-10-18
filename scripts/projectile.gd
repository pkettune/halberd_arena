class_name Projectile
extends Node2D

@export var speed := 700.0
@export var lifetime := 0.5

var direction := Vector2.ZERO

func _ready():
	set_as_top_level(true)
	look_at(position + direction)

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	await get_tree().create_timer(1.3).timeout
	queue_free()
#	rotation += 1						JA TÄMÄ
#	rotation = global_rotation_degrees     PYÖRII KU VÄKKYRS


func _on_hit_box_body_entered(body):
	queue_free()


func _on_hit_box_area_entered(area):
	queue_free()
