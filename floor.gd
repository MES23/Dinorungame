extends StaticBody2D

var gameover = false

func start():
	$AnimationPlayer.play("move")

func stop():
	if gameover:
		return
	
	$AnimationPlayer.pause()
	await get_tree().create_timer(1.15).timeout
	$AnimationPlayer.play()

func end():
	await get_tree().create_timer(.4).timeout
	gameover = true
	$AnimationPlayer.play("RESET")

func reset():
	gameover = false
