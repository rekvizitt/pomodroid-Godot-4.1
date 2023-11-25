extends Control

# variable is used in the logic of moving the window 
var following = false

var dragging_start_position = Vector2()
# current timer
var curr_timer
var temp_time = Global.focus_time
# current timer state
var timer_state = "stop"

func _on_titlebar_gui_input(event):
	if event is InputEventMouseButton:
		if event.get_button_index() == 1:
			following = !following
			dragging_start_position = get_local_mouse_position()

func _process(_delta):
	# current timer
	curr_timer = get_node("timers/" + Global.state + "_timer") 
	# set info and time
	set_rounds_info()
	set_state_label()
	set_time()
	# moving boardless window
	if following:
		get_window().position += Vector2i(get_global_mouse_position()) - Vector2i(dragging_start_position)

# set time
func set_time():
	if curr_timer.time_left != 0 and timer_state == "start":
		var minutes = int(curr_timer.time_left/60) % 60
		var seconds = int(curr_timer.time_left) % 60
		$time.text = "%02d : %02d" % [minutes, seconds]
	else:
		var minutes = int(temp_time/60) % 60
		var seconds = int(temp_time) % 60
		$time.text = "%02d : %02d" % [minutes, seconds]

# set rounds info
func set_rounds_info():
	$rounds_info.text = str(Global.gone_rounds) + "/" + str(Global.rounds)

# close button logic
func _on_close_button_pressed():
	get_tree().quit()

# minimize button logic
func _on_minimize_button_pressed():
	get_window().mode = 1

# on start button pressed logic
func _on_start_button_pressed():
	timer_state = "start"
	curr_timer.wait_time = temp_time
	curr_timer.start()
	$start_button.visible = false
	$stop_button.visible = true

# on stop button pressed logic
func _on_stop_button_pressed():
	timer_state = "stop"
	temp_time = curr_timer.time_left
	curr_timer.stop()
	$start_button.visible = true
	$stop_button.visible = false

func _on_skip_current_round_button_pressed():
	if Global.gone_rounds != Global.rounds and Global.state == "short_break":
		Global.gone_rounds += 1
	elif Global.gone_rounds == Global.rounds and Global.state == "long_break":
		Global.gone_rounds = 1
		# cycles +1
	$timers.change_state()
	await get_tree().create_timer(0.0001).timeout
	temp_time = curr_timer.wait_time
	if timer_state == "start":
		curr_timer.start()

# set state label
func set_state_label():
	if Global.state == "focus":
		$state_info.text = "Focus"
	elif Global.state == "short_break":
		$state_info.text = "Short Break"
	else:
		$state_info.text = "Long Break"


func _on_reset_timer_button_pressed():
	curr_timer.stop()
	timer_state = "stop"
	if Global.state == "focus":
		curr_timer.wait_time = Global.focus_time
	elif Global.state == "short_break":
		curr_timer.wait_time = Global.short_break_time
	else:
		curr_timer.wait_time = Global.long_break_time
	temp_time = curr_timer.wait_time
	$start_button.visible = true
	$stop_button.visible = false

func _on_options_button_pressed():
	$options_window.visible = true
	$go_back_button.visible = true
	$options_button.visible = false

func _on_go_back_button_pressed():
	$options_window.visible = false
	$go_back_button.visible = false
	$options_button.visible = true
