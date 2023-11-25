extends Node

# elapsed rounds
var gone_rounds = Global.gone_rounds
# state value
var state = Global.state

func _ready():
	# load data
	Global.load_data()
	# set base time to timers
	$focus_timer.wait_time = Global.focus_time
	$short_break_timer.wait_time = Global.short_break_time
	$long_break_timer.wait_time = Global.long_break_time

# focus timer timeout logic
func _on_focus_timer_timeout():
	# change state to short break or long break
	change_state()

# short break timer timeout logic
func _on_short_break_timer_timeout():
	# change state to focus
	change_state()
	# increase gone_rounds (one round is gone)
	Global.gone_rounds += 1

# long break timer timeout logic
func _on_long_break_timer_timeout():
	# change state to focus (all rounds done)
	change_state()
	# set zero to gone rounds
	Global.gone_rounds = 1

# changing state after state timer timeout
func change_state():
	if Global.gone_rounds != Global.rounds:
		Global.state = "short_break" if Global.state == "focus" else "focus"
	else:
		Global.state = "long_break" if Global.state == "focus" else "focus"
	# updating global state
	Global.save_data()
