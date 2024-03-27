extends Node2D

var entered = false
var xp = 1

@onready var player = get_node("/root/world/All/character")

func _physics_process(delta):
	get_node("animate/xp").modulate = Color.SKY_BLUE
	if entered == true:
		%AnimationPlayer.play("stop")
		var speed = player.global_position.distance_to(global_position)
		var distance = clamp(5000-speed,0,320)
		position = global_position.move_toward(player.global_position,distance*2*delta)
	else:
		%AnimationPlayer.play("idle")

func _on_grabbing_body_entered(body):
	if body.name == "character":
		Game.xp += xp
		queue_free()

func _on_pulling_body_entered(body):
	if body.name == "character":
		entered = true
		if %animate.scale != Vector2(0.5,0.5):
			xp = 5

