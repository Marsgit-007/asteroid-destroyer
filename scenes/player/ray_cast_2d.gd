extends RayCast2D

@export var beam_length:int
@onready var line_2d: Line2D = $Line2D

var tween: Tween


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	line_2d.visible = false
	print(beam_length)
	line_2d.add_point(position)
	print(target_position)
	target_position = target_position*beam_length
	print(target_position)
	line_2d.add_point(target_position)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("laser"):
		if line_2d.visible == false:
			line_2d.visible = true
		else:
			if line_2d.visible == true:
				line_2d.visible = false
	if line_2d.visible == true:
		ray_detection()
	else:
		return
	

func ray_detection():
	force_raycast_update()
	if is_colliding():
		if "asteroid" in get_collider():
			get_collider().destroy()
	else:
		print("no collisions")


	
