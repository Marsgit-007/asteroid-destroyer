extends CharacterBody2D

signal new_laser(initial_pos, direction, turn)

@onready var nose: Marker2D = $Nose
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var  SHIP_DAMAGED = preload("uid://bh1g76hmwspmp")
@onready var invulnerable_timer: Timer = $InvulnerableTimer
@onready var  SHIP_NORMAL = preload("uid://bcvmskil0iluw")



var nose_pos:Vector2
var direction
var speed:int = 10000
var turn_speed:int = 3
var power
var drag: float = 0.955
var elapsed_time:float = 0.0
var invulnerable:bool = false




func _physics_process(delta: float) -> void:
	globals.player_pos = global_position
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


func _on_area_2d_area_entered(area: Area2D) -> void:
	if "asteroid" in area and not invulnerable:
		
		sprite_2d.texture = SHIP_DAMAGED
		match area.type:
			"small":
				globals.health += -10
			"medium":
				globals.health += -20
			"large":
				globals.health += -30
				
		invulnerable = true
		invulnerable_timer.start()


func _on_invulnerable_timer_timeout() -> void:
	sprite_2d.texture = SHIP_NORMAL
	invulnerable = false


func tween(node, property, value, duration):
	var the_tween = create_tween()
	the_tween.tween_property(node, property, value, duration)
