extends Area2D

var speed = 2500
var arm_time = 5

func _ready():
	reparent(get_node("/root/world"))
	
func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	speed -= 5000 * delta
	position += direction * clamp(speed,0,2000) * delta
	arm_time -= delta
	if arm_time <= 0:
		explode()

func explode():
	const EXPLODE = preload("res://smoke_explosion/smoke_explosion.tscn")
	var explode = EXPLODE.instantiate()
	var targets = get_overlapping_bodies()
	for step in targets:
		if step.has_method("take_damage"):
			step.take_damage(4)
	get_parent().add_child(explode)
	explode.global_position = global_position
	explode.scale = Vector2(4,4)
	queue_free()

