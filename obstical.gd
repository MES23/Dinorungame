extends Area2D

var speed = 150
var moving = true

func _ready():
	$Sprite2D.texture = $Sprite2D.texture.duplicate()
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
	var i = randi_range(0, 4)
	if i == 0:
		$Sprite2D.texture.region = Rect2(1, 1, 8, 8)
		$Sprite2D.position = Vector2(0, 0)
		$CollisionShape2D.shape.size = Vector2(8, 8)
		$CollisionShape2D.position = Vector2(0, 0)
	elif i == 1:
		$Sprite2D.texture.region = Rect2(70, 26, 8, 8)
		$Sprite2D.position = Vector2(0, 0)
		$CollisionShape2D.shape.size = Vector2(8, 8)
		$CollisionShape2D.position = Vector2(0, 0)
	elif i == 2:
		$Sprite2D.texture.region = Rect2(25, 18, 8, 8)
		$Sprite2D.position = Vector2(0, 0)
		$CollisionShape2D.shape.size = Vector2(8, 8)
		$CollisionShape2D.position = Vector2(0, 0)
	elif i == 3:
		$Sprite2D.texture.region = Rect2(38, 26, 11, 8)
		$Sprite2D.position = Vector2(-1, 1)
		$CollisionShape2D.shape.size = Vector2(12, 8)
		$CollisionShape2D.position = Vector2(2, 0)
	elif i == 4:
		$Sprite2D.texture.region = Rect2(79, 35, 8, 8)
		$Sprite2D.position = Vector2(0, 0)
		$CollisionShape2D.shape.size = Vector2(8, 4)
		$CollisionShape2D.position = Vector2(0, 2)
	elif i == 5:
		$Sprite2D.texture.region = Rect2(17, 20, 6, 6)
		$Sprite2D.position = Vector2(2, 0)
		$CollisionShape2D.shape.size = Vector2(6, 6)
		$CollisionShape2D.position = Vector2(-1, 1)

func _process(delta):
	if not moving:
		return
	
	
	position.x -= speed * delta

func _on_body_entered(body):
	if "dinos" in body.get_groups():
		speed = 0
		body.get_parent().hit(body.colordino)
		queue_free()

func end():
	moving = false

func _on_animation_player_animation_finished(_anim_name):
	queue_free()

