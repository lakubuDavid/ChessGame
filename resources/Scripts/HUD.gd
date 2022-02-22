extends Control

onready var sfx_audio_bus = AudioServer.get_bus_index("Sfx")
onready var music_audio_bus = AudioServer.get_bus_index("Music")

# Called when the node enters the scene tree for the first time.
func _ready():
	$PauseMenu.visible = false
	$SettingsMenu/slider_music_volume.value = AudioServer.get_bus_volume_db(music_audio_bus)
	$SettingsMenu/slider_sfx_volume.value = AudioServer.get_bus_volume_db(sfx_audio_bus)
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
	AudioServer.set_bus_volume_db(sfx_audio_bus,value)
	$BtnClickSfx.play()
	pass # Replace with function body.


func _on_slider_music_volume_value_changed(value):
	AudioServer.set_bus_volume_db(music_audio_bus,value)
	pass # Replace with function body.
