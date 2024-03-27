extends Node2D
signal upgrade

const SPAWN_SPEED = 1
var spawn_points = []
var spawn_time = 0
var timer = 0.0

func _ready():
	var worldgen = WorldGen.new()
	worldgen._init()
	await get_tree().create_timer(1).timeout
	set_mob()
	spawn_wave()
	

func level_up():
	var overflow = Game.xp - Game.xp_max
	Game.playerLevel += 1
	Game.xp = overflow
	Game.xp_max += round(Game.xp_max - (Game.playerLevel / Game.enemyLevel))
	upgrade.emit()

func _on_spawn_timer_timeout():
		var random = randi_range(0,3)
		spawn_wave()
		%SpawnTimer.start(5+random)

func set_mob():
	%spawn.progress_ratio = randf()
	var spawn_position = %spawn.progress_ratio
	spawn_points.append(spawn_position)

func spawn_wave():
	for enemy in spawn_points:
		var spawn = load("res://slime.tscn").instantiate()
		%spawn.progress_ratio = enemy
		spawn.global_position = %spawn.global_position
		add_child(spawn)
		spawn_points.pop_front()
func _on_character_health_depleted():
	%GameOver.visible = true

func _physics_process(delta):
	if Input.is_action_just_released("test_button"):
		upgrade.emit()
	timer += delta
	spawn_time += SPAWN_SPEED * (Game.enemyLevel * delta)
	if spawn_time >= 5:
		print("spawning")
		set_mob()
		spawn_time = 0
	if timer >= 60:
		level_enemies()
	if Game.xp >= Game.xp_max:
		level_up()



func level_enemies():
	Game.enemyLevel += 1
	timer = 0
	print(Game.enemyLevel)

func _on_continue_pressed():
	get_tree().change_scene_to_file("res://world.tscn")

func _on_quit_pressed():
	get_tree().quit()
