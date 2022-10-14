extends StaticBody2D

var score = 0
var new_position = Vector2.ZERO
var dying = false
export var time_appear = 0.5
export var time_fall = 0.8 
export var time_rotate = 1.0
export var time_a = 0.8
export var time_s = 1.2
export var time_v = 1.5 

var powerup_prob = 0.1

func _ready():
	randomize()
	var spriteType = (randi() % 6)
	if (spriteType == 1): 
		$Sprite.texture = $Sprite2.texture
	if (spriteType == 2):
		$Sprite.texture = $Sprite3.texture
	if (spriteType == 3):
		$Sprite.texture = $Sprite4.texture
	if (spriteType == 4):
		$Sprite.texture = $Sprite5.texture
	if (spriteType == 5):
		$Sprite.texture = $Sprite6.texture
	position = new_position
	if score >= 100: 
		$Sprite.modulate = Color8(224,49,49)
	elif score >= 90: 
		$Sprite.modulate = Color8(255,146,43)
	elif score >= 80: 
		$Sprite.modulate = Color8(255,212,59)
	elif score >= 70: 
		$Sprite.modulate = Color8(148,216,45)
	elif score >= 60: 
		$Sprite.modulate = Color8(34,139,230)
	elif score >= 50: 
		$Sprite.modulate = Color8(132,94,247)
	elif score >= 40: 
		$Sprite.modulate = Color8(190,75,219)
	else:
		$Sprite.modulate = Color8(134,142,150)
func _physics_process(_delta):
	
 if dying and not $Confetti.emitting and not $Tween.is_active():
		queue_free()

func hit(_ball):
	var brick_sound = get_node_or_null("/root/Game/Brick_Sound")
	if brick_sound != null: 
		brick_sound.play()
	die()

func die():
	dying = true
	collision_layer = 0
	$Sprite.hide()
	Global.update_score(score)
	if not Global.feverish:
		Global.update_fever(score)
	get_parent().check_level()
	$Confetti.emitting = true
	if randf() < powerup_prob:
		var Powerup_Container = get_node_or_null("/root/Game/Powerup_Container")
		if Powerup_Container != null:
			var Powerup = load("res://Powerups/Powerup.tscn")
			var powerup = Powerup.instance()
			powerup.position = position
			Powerup_Container.call_deferred("add_child", powerup)
	$Tween.interpolate_property(self, "position", position, Vector2(position.x, 1000), time_fall, Tween.TRANS_EXPO, Tween.EASE_IN)
	$Tween.interpolate_property(self, "rotation", rotation, -PI + randf()*2*PI, time_rotate, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($ColorRect, "color:a", $ColorRect.color.a, 0, time_a, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($ColorRect, "color:s", $ColorRect.color.s, 0, time_s, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($ColorRect, "color:v", $ColorRect.color.v, 0, time_v, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

