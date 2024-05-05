extends CharacterBody2D

var health = 2.0
var xp = 1
const MAX_SPEED = [Vector2(300,0),Vector2(0,300),Vector2(-300,0),Vector2(0,-300)]

@onready var player = get_node("/root/world/All/character")

func _ready():
		%Slime.play_walk()

func _physics_process(delta):
		if (player != null):
			var direction = global_position.direction_to(player.global_position)
			velocity = direction * 300
			move_and_slide()

func take_damage(amount):
		health -= amount
		%Slime.play_hurt()
		if health <= 0:
			const SMOKE_SCENE = preload("res://Scenes/smoke_explosion.tscn")
			var smoke = SMOKE_SCENE.instantiate()
			get_parent().add_child(smoke)
			smoke.global_position = global_position
			die()
			queue_free()

func die():
	const XP = preload("res://Scenes/xp.tscn")
	xp = Game.enemyLevel
	while xp >= 5:
		var xpspawn = XP.instantiate()
		get_parent().add_child(xpspawn)
		xpspawn.global_position = global_position + Vector2(randf_range(-32,32),randf_range(-32,32))
		xp -= 5
	while xp > 0:
		var xpspawn = XP.instantiate()
		get_parent().call_deferred("add_child", xpspawn)
		xpspawn.global_position = global_position + Vector2(randf_range(-32,32),randf_range(-32,32))
		var rescale = xpspawn.find_child("animate")
		rescale.scale = Vector2(0.5,0.5)
		xp -= 1
