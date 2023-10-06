class_name Projectile
extends Node2D

@export var speed := 1000.0
@export var lifetime := 3.0

var direction := Vector2.ZERO

#@onready var timer := $Timer
@onready var hitbox := $Spear/CollisionShape2D
@onready var sprite := $SpearSprite
@onready var impact_detector := $ImpactDetector

func _ready():
	set_as_top_level(true)
	look_at(position + direction)
	
# TIMER ITMERIMT TIMER ANPAN ANPAN ANPAN ANPAN ANPAN ANPAN

# impact detector

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_impact(_body: Node) -> void:
	queue_free()
