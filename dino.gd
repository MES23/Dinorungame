extends CharacterBody2D

@export var startpos: Vector2
@export var colordino: String
@export var colorname: String
const JUMP_VELOCITY = -250.0
var moving = false
var finish = false
var speed = 150


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	startpos = global_position

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump.
	if Input.is_action_just_pressed(colordino + "jump") and is_on_floor() and moving:
		velocity.y = JUMP_VELOCITY
	
	move_and_slide()
	
	if finish:
		position.x += speed * delta

func go():
	moving = true
	$AnimationPlayer.play("running")


func stop():
	moving = false
	$AnimationPlayer.play("hit")
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play("respawn")
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play("running")
	moving = true
 

func end(names):
	moving = false
	if colorname not in names:
		$AnimationPlayer.play("idle")
	else:
		finish = true
		await get_tree().create_timer(1.3).timeout
		finish = false
		$AnimationPlayer.play("idle")

