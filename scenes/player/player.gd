extends CharacterBody2D

signal new_laser(initial_pos, direction, turn)

@onready var nose: Marker2D = $Nose
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

var nose_pos:Vector2
var direction
var speed:int = 10000
var turn_speed:int = 3
var power
var drag: float = 0.955

func _physics_process(delta: float) -> void:
	
	power = Input.get_action_strength("up")
	rotation += Input.get_axis("left", "right")*delta*turn_speed
	direction = (nose.global_position-position).normalized()
	
	if Input.is_action_just_pressed("shoot"):
		new_laser.emit(nose.global_position, direction, rotation_degrees)
	
	if power != 0:
		gpu_particles_2d.emitting = true
		velocity = direction*speed*power*delta
	else:
		gpu_particles_2d.emitting = false
		velocity *= drag
	move_and_slide()
