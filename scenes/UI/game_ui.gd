extends Control

@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar
@onready var hide_bar_timer: Timer = $HideBarTimer



func _ready() -> void:
	globals.change_health_bar.connect(update_healthbar)
	texture_progress_bar.value = globals.health

func update_healthbar(health):
	tween(texture_progress_bar, "modulate:a", 255 , 1)
	tween(texture_progress_bar, "value", health, 1)
	hide_bar_timer.start()


	
func tween(node, property, value, duration):
	var property_tween = create_tween()
	property_tween.tween_property(node, property, value, duration)

func tween_timer(delay):
	var timer_tween = create_tween()
	timer_tween.tween_interval(delay)


func _on_hide_bar_timer_timeout() -> void:
	tween(texture_progress_bar, "modulate:a", 0 ,2)
