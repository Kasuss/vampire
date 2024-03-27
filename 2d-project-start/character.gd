extends CharacterBody2D
signal health_depleted

var health = 100

func _physics_process(delta):
		var direction = Input.get_vector("move_left","move_right","move_up","move_down")
		velocity = direction * 600
		move_and_slide()
		
		if velocity.length() > 0.0:
			get_node("HappyBoo").play_walk_animation()
		else:
			get_node("HappyBoo").play_idle_animation()
		
		const DAMAGE_RATE = 1.0
		var overlapping_mobs = %hurtbox.get_overlapping_bodies()
		if overlapping_mobs.size() > 0:
			const BLEED = preload("res://bleed.tscn")
			var bleed = BLEED.instantiate()
			var damage : float = DAMAGE_RATE * Game.enemyLevel / 5
			health -= clamp(damage * overlapping_mobs.size() * delta,0.1,10)
			%HappyBoo.get_node("Colorizer").modulate = Color8(170,0,0,255)
			%health.value = health
			add_child(bleed)
			bleed.global_position = global_position
			if health <= 0.0:
				health_depleted.emit()
		else:
			%HappyBoo.get_node("Colorizer").modulate = Color8(255,146,45,255)
