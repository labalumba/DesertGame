extends Node2D


func _input(event):
	if event.is_action_pressed("pause"):
		get_node("Control/optionsMenu").visible = false
		get_node("Control/pauseMenu").visible = true
		var pause_state = not get_tree().paused		
		get_tree().paused = pause_state
		visible = pause_state
		if (pause_state):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	


func _on_Button_pressed():
	get_tree().quit(3)


func _on_Button2_pressed():
	get_node("Control/optionsMenu").visible = true
	get_node("Control/pauseMenu").visible = false



func _on_backButton_pressed():
	get_node("Control/optionsMenu").visible = false
	get_node("Control/pauseMenu").visible = true


func _on_resumeButton_pressed():
	get_tree().paused = false
	visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
