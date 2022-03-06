extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$PauseMenu.visible = false
	$SettingsMenu/ScrollContainer/controls/slider_music_volume.value = Game.music_volume
	$SettingsMenu/ScrollContainer/controls/slider_sfx_volume.value = Game.sfx_volume
	$SettingsMenu/ScrollContainer/controls/show_moves_checkbutton.pressed = Game.show_moves
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


func _on_btn_setting_pressed():
	$BtnClickSfx.play()
	$PauseMenu.visible = false
	$SettingsMenu.visible = true
	pass # Replace with function body.


func _on_btn_settings_backs_pressed():
	$BtnClickSfx.play()
	$PauseMenu.visible = true
	$SettingsMenu.visible = false
	pass # Replace with function body.

func _on_slider_sfx_volume_value_changed(value):
	Game.set_sfx_volume(value)
	$BtnClickSfx.play()
	pass # Replace with function body.


func _on_slider_music_volume_value_changed(value):
	Game.set_music_volume(value)
	pass # Replace with function body.

func _on_btn_new_game_pressed():
	Game.restart_game()
	$PauseMenu.visible = false
	$GameFinishedScreen.visible = false
	get_tree().paused = false
	$BtnClickSfx.play()
	pass # Replace with function body.


func _on_btn_restart_pressed():
	$BtnClickSfx.play()
	Game.restart_game()
	get_tree().paused = false
	$PauseMenu.visible = false
	pass # Replace with function body.

func _on_show_moves_checkbutton_pressed():
	Game.show_moves = $SettingsMenu/ScrollContainer/controls/show_moves_checkbutton.pressed
	pass # Replace with function body.


