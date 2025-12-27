extends Node

signal change_difficulty(level:String)
signal change_health_bar(new_health)
signal change_score_label(new_score)

var player_pos:Vector2
var health:int = 100:
	set(value):
		if health == value:
			return
		health = value
		change_health_bar.emit(value)
		if health <= 0:
			print("dead")
		
var score:int = 0:
	set(value):
		if score == value:
			return
		score = value
		change_score_label.emit(score)
		if value == 500:
			change_difficulty.emit("medium")
		if value >= 1000 and value < 20000:
			change_difficulty.emit("hard")
		if value >= 2000 and value < 3000:
			change_difficulty.emit("crazy")
		if value >= 3000:
			change_difficulty.emit("impossible")
