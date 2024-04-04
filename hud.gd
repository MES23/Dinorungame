extends CanvasLayer

signal go

func _on_button_pressed():
	$Button.hide()
	$Label.show()
	await get_tree().create_timer(1).timeout
	$Label.text = "2"
	await get_tree().create_timer(1).timeout
	$Label.text = "1"
	await get_tree().create_timer(1).timeout
	$Label.text = "GO"
	await get_tree().create_timer(.2).timeout
	$Control.hide()
	$Label.hide()
	go.emit()


func _on_main_winner(names):
	if names.size() > 1:
		var t = ""
		var l = 0
		for n in names:
			if l == 0 :
				t += n
			else:
				t += " and " + n
			l += 1
		$winlabel.text = t + " dinos win!"
	else:
		$winlabel.text = names[0] + " dino wins!"

func reset():
	$winlabel.text = ""
	$Button.show()
	$Control.show()
