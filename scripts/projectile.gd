class_name Projectile
extends Node2D

@export var player_scene: PackedScene = preload("res://scenes/player.tscn")
@onready var player = get_node("/root/Main/Player/")

@onready var timer := $Timer
@onready var hitbox := $HitBox
@onready var sprite := $Sprite
@onready var impact_detector := $ImpactDetector

@export var speed := 700.0
@export var lifetime := 0.2
var direction := Vector2.ZERO

func _ready():
	set_as_top_level(true)
	look_at(position + direction)

func _on_timer_timeout():
	timer.start(lifetime)
	
func _physics_process(delta: float) -> void:
	position += direction * speed * delta
#	rotation += 1						JA TÄMÄ
#	rotation = global_rotation_degrees     PYÖRII KU VÄKKYRS

func _on_impact_detector_body_entered(body):
	await get_tree().create_timer(0.03).timeout
	queue_free()
	
