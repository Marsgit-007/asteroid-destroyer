extends Area2D

var moving:bool = false
var movement_vector:Vector2
var speed:int = 300

func fire(initial_pos, direction):
	global_position = initial_pos
	movement_vector = direction
	moving = true

func _physics_process(delta: float) -> void:
	if moving:
		position += movement_vector*delta*speed
	else:
		return
		


func _on_area_entered(area: Area2D) -> void:
	if "asteroid" in area:
		area.destroy()
	else:
		return
