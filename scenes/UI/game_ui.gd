extends Control

@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar
@onready var hide_bar_timer: Timer = $HideBarTimer
@onready var score_label: RichTextLabel = $MarginContainer/ScoreLabel



func _ready() -> void:
	globals.change_health_bar.connect(update_healthbar)
	texture_progress_bar.value = globals.health
	globals.change_score_label.connect(update_score_label)

func update_healthbar(health):
	tween(texture_progress_bar, "modulate:a", 255 , 1)
	tween(texture_progress_bar, "value", health, 1)
	hide_bar_timer.start()

func update_score_label(score):
	score_label.text = "score: %s" % [str(score)]
	


	
func tween(node, property, value, duration):
	var property_tween = create_tween()
	property_tween.tween_property(node, property, value, duration)

func tween_timer(delay):
	var timer_tween = create_tween()
	timer_tween.tween_interval(delay)


func _on_hide_bar_timer_timeout() -> void:
	tween(texture_progress_bar, "modulate:a", 0 ,2)
