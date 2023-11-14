extends CharacterBody2D

const SPEED = 150.0
const ACCELERATION = 1200.0
const DECELERATION = 500.0
var bullet_scene = preload("res://bullet.tscn")

var shooting_direction = Vector2.RIGHT

func _physics_process(delta):
	var shootdir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	if shootdir != Vector2.ZERO:
		shooting_direction = shootdir

	# Flip sprite when looking left
	$Sprite.flip_v = shooting_direction.x < 0

	var direction = Input.get_vector("left", "right", "up", "down").normalized()
	
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, DECELERATION * delta)
	
	move_and_slide()

	rotation = shooting_direction.angle()

	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.rotation = shooting_direction.angle()
	bullet.position = position
	bullet.velocity = shooting_direction * bullet.SPEED
	get_tree().current_scene.add_child(bullet)


