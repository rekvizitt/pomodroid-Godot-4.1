extends Node

var gone_rounds
var state = Global.state

func _ready():
	# load data
	Global.load_data()
	# set time to timers
	$focus_timer.wait_time = Global.focus_time
	$short_break_timer.wait_time = Global.short_break_time
	$long_break_timer.wait_time = Global.long_break_time


func _on_focus_timer_timeout():
	# change state to short break or long break
	change_state()


func _on_short_break_timer_timeout():
	# change state to focus
	change_state()
	# increase gone_rounds (one round is gone)
	gone_rounds += 1


func _on_long_break_timer_timeout():
	# change state to focus (all rounds done)
	change_state()
	# set zero to gone rounds
	gone_rounds = 0


func change_state():
	if gone_rounds == Global.rounds:
		state = "short_break" if state == "focused" else "focused"
	else:
		state = "long_break" if state == "focused" else "focused"
