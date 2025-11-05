extends Node2D

@onready var pcam: PhantomCamera2D = $PhantomCamera2D
@onready var player: CharacterBody2D = $Player
@onready var laser_scene: PackedScene = preload("res://scenes/player/laser.tscn")
@onready var lasers: Node2D = $Lasers
@onready var asteroid_timer: Timer = $AsteroidTimer
@onready var asteroid_scene: PackedScene = preload("res://scenes/asteroids/asteroid.tscn")
@onready var asteroid_resources:Array = [preload("res://resources/asteroids/small.tres"), preload("res://resources/asteroids/medium.tres"), preload("res://resources/asteroids/large.tres")]
@onready var asteroids: Node2D = $Asteroids
@onready var top_spawn_points: Array = $TopSpawnPoints.get_children()
@onready var bottom_spawn_points: Array = $BottomSpawnPoints.get_children()
@onready var left_spawn_points: Array = $LeftSpawnPoints.get_children()
@onready var right_spawn_points: Array = $RightSpawnPoints.get_children()

var laser
var asteroid 
var coordinates:Vector2
var axis:Array
var direction:Vector2
var asteroid_direction:Vector2



func _ready() -> void:
	player.new_laser.connect(fire_laser)
	globals.change_difficulty.connect(challenge_change)
	asteroid_timer.start()


func fire_laser(initial_pos, laser_direction, laser_rotation):
	
	laser = laser_scene.instantiate()
	laser.rotation_degrees = laser_rotation
	laser.global_position = initial_pos
	lasers.add_child(laser)
	laser.fire(initial_pos, laser_direction)
	


func _on_asteroid_timer_timeout() -> void:
	new_asteroid()

func new_asteroid():
	asteroid = asteroid_scene.instantiate()
	asteroids.add_child(asteroid)
	var axis_code = randi_range(0,3)
	match axis_code:
		0:
			axis = left_spawn_points
			asteroid_direction = Vector2(1,randf_range(-0.5, 0.5))
		1:
			axis = right_spawn_points
			asteroid_direction = Vector2(-1,randf_range(-0.5, 0.5))
		2:
			axis = top_spawn_points
			asteroid_direction = Vector2(randf_range(-0.5, 0.5),1)
		3:
			axis = bottom_spawn_points
			asteroid_direction = Vector2(randf_range(-0.5, 0.5),-1)
			
	coordinates = axis[randi_range(0, len(axis)-1)].position
	
	asteroid.populate(coordinates, asteroid_resources[2])
	asteroid.move(asteroid_direction)

func challenge_change(new_level):
	pass # challenge change script start here!


func _on_asteroid_detection_area_entered(area: Area2D) -> void:
	area.queue_free()


func _on_laser_detection_area_entered(area: Area2D) -> void:
	area.queue_free()
