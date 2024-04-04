extends Node2D

@export var obstical: PackedScene
@export var finishline: PackedScene
@export var win: int
signal winner
signal reset

var winnerlist = []

var rtime = 0
var rcleared = 0
var btime = 0
var bcleared = 0
var gtime = 0
var gcleared = 0
var ytime = 0
var ycleared = 0
var gameover = false


func _on_hud_go():
	get_tree().call_group("background", "start")
	get_tree().call_group("dinos", "go")
	$Timer.start()

func hit(color):
	if gameover:
		return
	
	get_tree().call_group(color + "dino", "stop")
	await get_tree().create_timer(1.2).timeout
	spawnbycolor(color)
	if color == "b":
		btime = 5
	elif color == "y":
		ytime = 5
	elif color == "r":
		rtime = 5
	elif color == "g":
		gtime = 5

func spawnbycolor(color):
	if gameover:
		return
	
	if color == "b":
		var newob = obstical.instantiate()
		newob.position.y += 46
		get_tree().root.add_child(newob)
	elif color == "g":
		var newob = obstical.instantiate()
		newob.position.y += 102
		get_tree().root.add_child(newob)
	elif color == "r":
		var newob = obstical.instantiate()
		newob.position.y += 158
		get_tree().root.add_child(newob)
	elif color == "y":
		var newob = obstical.instantiate()
		newob.position.y += 214
		get_tree().root.add_child(newob)



func _on_timer_timeout():
	rtime += 1
	gtime += 1
	btime += 1
	ytime += 1
	
	if rtime % 5 == 0:
		spawnbycolor("r")
		if rtime > 5:
			rcleared += 1
			$CanvasLayer/TextureRect/rmark.position.x += int(250 / win)
	if ytime % 5 == 0:
		spawnbycolor("y")
		if ytime > 5:
			ycleared += 1
			$CanvasLayer/TextureRect/ymark.position.x += int(250 / win)
	if btime % 5 == 0:
		spawnbycolor("b")
		if btime > 5:
			bcleared += 1
			$CanvasLayer/TextureRect/bmark.position.x += int(250 / win)
	if gtime % 5 == 0:
		spawnbycolor("g")
		if gtime > 5:
			gcleared += 1
			$CanvasLayer/TextureRect/gmark.position.x += int(250 / win)
	
	if bcleared == win:
		winnerlist.append("blue")
	if rcleared == win:
		winnerlist.append("red")
	if gcleared == win:
		winnerlist.append("green")
	if ycleared == win:
		winnerlist.append("yellow")
	
	if winnerlist.size() > 0:
		gameover = true
		finline()
		get_tree().call_group("obstical", "end")
		get_tree().call_group("dinos", "end", winnerlist)
		get_tree().call_group("background", "end")
		get_tree().call_group("finishline", "end")
		$Timer.stop()
		await get_tree().create_timer(1.3).timeout
		winner.emit(winnerlist)


func finline():
	if "blue" in winnerlist:
		var finish = finishline.instantiate()
		finish.position.y += 36
		get_tree().root.add_child(finish)
	if "green" in winnerlist:
		var finish = finishline.instantiate()
		finish.position.y += 92
		get_tree().root.add_child(finish)
	if "red" in winnerlist:
		var finish = finishline.instantiate()
		finish.position.y += 148
		get_tree().root.add_child(finish)
	if "yellow" in winnerlist:
		var finish = finishline.instantiate()
		finish.position.y += 204
		get_tree().root.add_child(finish)
	
	await get_tree().create_timer(8).timeout
	reset.emit()


func _on_reset():
	$BDino.global_position = $BDino.startpos
	$RDino.global_position = $RDino.startpos
	$YDino.global_position = $YDino.startpos
	$GDino.global_position = $GDino.startpos
	get_tree().call_group("obstical", "queue_free")
	get_tree().call_group("background", "reset")
	get_tree().call_group("finishline", "queue_free")
	btime = 0
	bcleared = 0
	rtime = 0
	rcleared = 0
	gtime = 0
	gcleared = 0
	ytime = 0
	ycleared = 0
	$CanvasLayer/TextureRect/bmark.position.x = 3
	$CanvasLayer/TextureRect/gmark.position.x = 3
	$CanvasLayer/TextureRect/rmark.position.x = 3
	$CanvasLayer/TextureRect/ymark.position.x = 3
	winnerlist.clear()
	gameover = false
	$HUD.reset()
	
