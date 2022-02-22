extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$PauseMenu.visible = false
	pass # Replace with function body.

func _process(delta):
	if(Input.is_action_just_pressed("pause")):
		$PauseSfx.play()
		get_tree().paused = true
		$PauseMenu.visible = true
		pass

func _on_btn_quit_game_pressed():
	$BtnClickSfx.play()
	get_tree().quit()
	pass # Replace with function body.


func _on_btn_resume_pressed():
	$BtnClickSfx.play()
	get_tree().paused = false
	$PauseMenu.visible = false
	pass # Replace with function body.
