extends Node2D

@onready var sprite = %Sprite
@onready var flash = get_node("/root/world/All/character/gun/pivot/Pistol/shoot")


func _ready():
	var tween = create_tween().set_parallel(true).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.tween_property(sprite, "scale", Vector2.ONE * 1.25, 0.25)
	tween.tween_property(sprite, "modulate:a", 0.0, 0.25).set_delay(0.1)
	tween.chain().tween_callback(queue_free)

func _physics_process(_delta):
	%Sprite.global_position = flash.global_position
	%Sprite.global_rotation = flash.global_rotation
