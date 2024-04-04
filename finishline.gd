extends Node2D

var speed = 150
var moving = true

func _process(delta):
	if not moving:
		return
	
	position.x -= speed * delta

func end():
	await get_tree().create_timer(.4).timeout
	moving = false
