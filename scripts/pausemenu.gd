extends Control

@onready var main = $"../"
@onready var spawner = $"../Spawner/"
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



func _on_check_button_toggled(button_pressed):
	if button_pressed:
		spawner.enemy1 = true
	else:
		spawner.enemy1 = false

func _on_check_button_2_toggled(button_pressed):
	if button_pressed:
		spawner.enemy2 = true
	else:
		spawner.enemy2 = false
		
func _on_check_button_3_toggled(button_pressed):
	if button_pressed:
		spawner.enemy3 = true
	else:
		spawner.enemy3 = false


