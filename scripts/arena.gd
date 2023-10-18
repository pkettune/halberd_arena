extends Node2D

func _on_floor_body_exited(body):
	body.queue_free()
	print("body exited arena")
