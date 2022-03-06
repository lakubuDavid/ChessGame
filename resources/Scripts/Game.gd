extends Node

var board
onready var sfx_audio_bus = AudioServer.get_bus_index("Sfx")
onready var music_audio_bus = AudioServer.get_bus_index("Music")

var show_moves : bool = false
var sfx_volume : float
var music_volume : float

func restart_game():
    board.reset_board()
    pass

func set_sfx_volume(value):
    sfx_volume = value
    AudioServer.set_bus_volume_db(sfx_audio_bus,value)
    pass

func set_music_volume(value):
    music_volume = value
    AudioServer.set_bus_volume_db(music_audio_bus,value)
    pass

func load_settings():
    pass

func save_settings():
    pass