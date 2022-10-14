extends Node2D
var score_threshold = 200
var b = 0
var backgrounds = [
	preload("res://Assets/backgroundCastles.png"
	,preload("res://Assets/backgroundColorDesert.png"
	,preload("res://Assets/backgroundColorFall.png")
]


func _ready():
	pass
func _physics_process(_delta):
	if Global.score > score_threshold*(b+1):
		var B2 = Sprite.new()
		B2.centered = false
		B2.texture = backgrounds[wrapi(b, 0, backgrounds.size())]
		B2.name = "B2"
		add_child(B2)
		move_child(B2, 0)
		$Background.hide()
