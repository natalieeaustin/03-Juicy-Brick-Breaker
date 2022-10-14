extends AudioStreamPlayer

var music = [ 
	preload("res://Assets/music1.ogg")
	,preload("res://Assets/music2.ogg")
	,preload("res://Assets/music3.ogg")
]
var which_music = 0 

func _ready():
	randomize()
	which_music = randi() % music.size ()
	stream = music[which_music]
	playing = true 


func _on_Music_finished():
	which_music = randi() % music.size ()
	stream = music[which_music]
	playing = true 
