extends Node2D

const enemy_scene = preload("res://scenes/enemy.tscn")
const player_scene = preload("res://scenes/player.tscn")


func _on_floor_body_exited(body):
	body.queue_free()

func _ready():
	randomize()

func _on_spawn_timer_timeout():
	var spawn_location = $SpawnPath/SpawnLocation
	spawn_location.progress_ratio = randf()
	
	var enemy = enemy_scene.instantiate()
	add_child(enemy)
	
	enemy.position = spawn_location.position

	var direction = spawn_location.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4)
	enemy.rotation = direction
	
	var velocity = Vector2(randf_range(20, 800), 0)
	enemy.velocity = velocity.rotated(direction)
	
