class_name Projectile
extends Node2D

@export var player_scene: PackedScene = preload("res://scenes/player.tscn")
@onready var player = get_node("/root/Main/Player/")

@onready var hitbox := $HitBox
@onready var sprite := $Sprite

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
