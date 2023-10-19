extends Node2D

@onready var enemy_scene = preload("res://scenes/enemy.tscn")
@onready var enemy_scene_2 = preload("res://scenes/enemy_2.tscn")
@onready var enemy_scene_3 = preload("res://scenes/enemy_3.tscn")

@export var enemy1 : bool = false
@export var enemy2 : bool = false
@export var enemy3 : bool = false


func _ready():
	randomize()



func _on_spawn_timer_timeout():
	var spawn_location = $SpawnPath/SpawnLocation
	spawn_location.progress_ratio = randf()
	
	var enemy = enemy_scene.instantiate()
	var enemy_2 = enemy_scene_2.instantiate()
	var enemy_3 = enemy_scene_3.instantiate()
	
	if enemy1 == true:
		add_child(enemy)
	if enemy2 == true:
		add_child(enemy_2)
	if enemy3 == true:
		add_child(enemy_3)
	
	enemy.position = spawn_location.position
	enemy_2.position = spawn_location.position
	enemy_3.position = spawn_location.position
	
	var direction = spawn_location.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4)
	
	enemy.rotation = direction
	enemy_2.rotation = direction * 2
	enemy_3.rotation = direction * 4
	
#	var velocity = Vector2(randf_range(20, 800), 0)
#	enemy.velocity = velocity.rotated(direction)
	


func _on_pause_menu_wait_time_value(value):
	$SpawnTimer.wait_time = value
