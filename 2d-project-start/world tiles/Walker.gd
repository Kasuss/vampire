extends Node2D
class_name Walker

const DIRECTIONS = [Vector2(1024,0), Vector2(0,-1024), Vector2(-1024,0), Vector2(0,1024)]

var pos = Vector2(1024,1024)
var direction = Vector2(1024,0)
var borders = Rect2()
var step_history = []
var steps_since_turn = 0

func _init(starting_position, new_borders):
	assert(new_borders.has_point(starting_position))
	pos = starting_position
	step_history.append(pos)
	borders = new_borders
	
func walk(steps):
	for stepd in steps:
		if randf() <= 0.25 or steps_since_turn >= 4:
			change_direction()
		if step():
			step_history.append(pos)
		else:
			change_direction()
	return step_history
	
func step():
	var target_position = pos + direction
	if borders.has_point(target_position):
		steps_since_turn += 1
		pos = target_position
		return true
	else:
		return false

func change_direction():
	steps_since_turn = 0
	var directions = DIRECTIONS.duplicate()
	directions.erase(direction)
	directions.shuffle()
	direction = directions.pop_front()
	while not borders.has_point(pos + direction):
		direction = directions.pop_front()

