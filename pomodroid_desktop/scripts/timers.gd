extends Node

# elapsed rounds
var gone_rounds = Global.gone_rounds
# state value
var state = Global.state


func _ready():
	# load data
	Global.load_data()
	# set base time to timers
	$focus_timer.wait_time = Global.data["focus_time"]
	$short_break_timer.wait_time = Global.data["short_break_time"]
	$long_break_timer.wait_time = Global.data["long_break_time"]

# focus timer timeout logic
func _on_focus_timer_timeout():
	# plays sound
	play_sound()
	# change state to short break or long break
	change_state()

# short break timer timeout logic
func _on_short_break_timer_timeout():
	# plays sound
	play_sound()
	# change state to focus
	change_state()
	# increase gone_rounds (one round is gone)
	Global.gone_rounds += 1

# long break timer timeout logic
func _on_long_break_timer_timeout():
	# plays sound
	play_sound()
	# change state to focus (all rounds done)
	change_state()
	# set zero to gone rounds
	Global.gone_rounds = 1

# changing state after state timer timeout
func change_state():
	if Global.gone_rounds != Global.data["rounds"]:
		Global.state = "short_break" if Global.state == "focus" else "focus"
	else:
		Global.state = "long_break" if Global.state == "focus" else "focus"
	# updating global state
	Global.save_data()

func play_sound():
	$AudioStreamPlayer.volume_db = lerpf(-25, 5, Global.data["sound"] / 100)
	if Global.data["sound"] == 0:
		$AudioStreamPlayer.volume_db = -80
	if $AudioStreamPlayer.is_playing():
		$AudioStreamPlayer.stop()
	if Global.state == "focus":
		$AudioStreamPlayer.stream = load("res://assets/sounds/sound_1.wav")
		$AudioStreamPlayer.play()
	elif Global.state == "short_break":
		$AudioStreamPlayer.stream = load("res://assets/sounds/sound_2.wav")
		$AudioStreamPlayer.play()
	elif Global.state == "long_break":
		$AudioStreamPlayer.stream = load("res://assets/sounds/sound_3.wav")
		$AudioStreamPlayer.play()
