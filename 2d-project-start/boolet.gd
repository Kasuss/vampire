extends Area2D

var travelled_distance = 0
var contact = Vector2(0,0)

func _ready():
	const FLASH = preload("res://pistol/muzzle_flash/muzzle_flash.tscn")
	var flash = FLASH.instantiate()
	add_child(flash)


func _physics_process(delta):
	const SPEED = 1000
	const RANGE = 1200
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()

func _on_body_entered(body):
	contact = global_position
	queue_free()
	if body.has_method("take_damage"):
		const IMPACT = preload("res://pistol/impact/impact.tscn")
		var impact = IMPACT.instantiate()
		if Game.inventory["Ricochet"] > 0:
			for bullet in Game.inventory["Ricochet"]:
				const RICOCHET = preload("res://boolet_ricochet.tscn")
				var ricochet = RICOCHET.instantiate()
				body.add_child(ricochet)
				ricochet.global_position = global_position
		get_parent().add_child(impact)
		impact.global_position = contact
		body.take_damage(1)

