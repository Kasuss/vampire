extends Area2D

@onready var player = get_node("/root/world/All/character")
@onready var flip = get_node("pivot/Pistol")
var grenade_ready = true

func _physics_process(delta):
		var spotted = get_overlapping_bodies()
		if Game.inventory["Grenades"] > 0 and grenade_ready:
			%Grenade.start(5)
			grenade_ready = false
		if spotted.size() > 0:
			var target_enemy = spotted.front()
			var angle = get_angle_to(player.global_position) * 100
			look_at(target_enemy.global_position)
			%Timer.start
			if angle < 0:
				flip.flip_v = true
			else:
				flip.flip_v = false
		else:
			%Timer.stop
			

func shoot():
		const BULLET = preload("res://boolet.tscn")
		var new_bullet = BULLET.instantiate()
		if flip.flip_v == true:
			%shoot.position.y = 11
		else:
			%shoot.position.y = -11
		new_bullet.global_position = %shoot.global_position
		new_bullet.global_rotation = %shoot.global_rotation
		%shoot.add_child(new_bullet)


func _on_timer_timeout():
	var spotted = get_overlapping_bodies()
	if spotted.size() > 0:
		shoot()

func _on_grenade_timeout():
	print("hiounfewasoaw")
	const GRENADE = preload("res://grenade.tscn")
	var grenade = GRENADE.instantiate()
	var nades = Game.inventory["Grenades"]
	add_child(grenade)
	grenade.global_position = %shoot.global_position
	grenade.global_rotation = randi_range(0,360)
	grenade_ready = true
	
