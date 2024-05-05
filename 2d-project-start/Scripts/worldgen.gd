extends Node2D
class_name WorldGen

var map_size = 1024 * 250
var borders = Rect2(map_size/-2,map_size/-2,map_size,map_size)
var used = []
var current_location = Vector2(0,0)
var new = false

func _init():
	generate_level()
	randomize()
	
func generate_level():
	var walker = Walker.new(Vector2(1024,1024), borders)
	var map = walker.walk(1250)
	walker.queue_free()
	for location in map:
		var step = randi_range(0,12)
		var tile = load(Game.tiles[step%4])
		var new_tile = tile.instantiate()
		add_child(new_tile)
		new_tile.global_position = location
		current_location = location
		used.append(current_location)
