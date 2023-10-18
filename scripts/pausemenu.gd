extends Control

@onready var main = $"../"
@onready var spawnTimer = $"../Spawner/SpawnTimer"
@onready var label = $MarginContainer/VBoxContainer/HSlider/Label


func _on_resume_pressed():
	main.pauseMenu()

func _on_quit_pressed():
	get_tree().quit()

func _on_value_changed(value: float) -> void:
	spawnTimer.wait_time = value
	label.text = "Enemy Spawning rate" + " " + str(value) + " " + "sec"
	print(spawnTimer.wait_time)
