extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var light_occluder_2d: LightOccluder2D = $LightOccluder2D
@onready var show_timer: Timer = $ShowTimer

var asteroid
var moving:bool = false
var movement_vector:Vector2
var speed:int = 50



func _physics_process(delta: float) -> void:
	if moving:

		rotation += 3*delta
		global_position += movement_vector*delta*speed

	else:
		return

func populate(pos:Vector2, data:AsteroidInfo):
	global_position = pos
	sprite_2d.texture = data.icon 
	collision_shape_2d.shape = data.collider
	light_occluder_2d.occluder = data.occluder


func move(direction):
	movement_vector = direction
	moving = true
	show_timer.start()

func _on_show_timer_timeout() -> void:
	visible = true
