extends Node

signal change_difficulty(level:String)

var player_pos:Vector2
var score:int = 0:
	set(value):
		if score == value:
			return
		score = value
		if value == 500:
			change_difficulty.emit("medium")
		if value >= 1000 and value < 20000:
			change_difficulty.emit("hard")
		if value >= 2000 and value < 3000:
			change_difficulty.emit("crazy")
		if value >= 3000:
			change_difficulty.emit("impossible")
