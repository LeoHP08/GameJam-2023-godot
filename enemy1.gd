extends CharacterBody2D

var speed = 70
var player

func _ready():
	# Assuming the player is the only node named "Player" in the scene
	player = get_node("/root/Node2D/Player")

func _physics_process(delta):
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
