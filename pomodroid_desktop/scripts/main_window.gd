extends Control

var following = false
var dragging_start_position = Vector2()
var state = Global.state
var state_timer
func _on_titlebar_gui_input(event):
	if event is InputEventMouseButton:
		if event.get_button_index() == 1:
			following = !following
			dragging_start_position = get_local_mouse_position()

func _process(_delta):
	$state_info.text = Global.state
	state_timer = get_node("timers/" + state + "_timer")
	$time.text = str(int(state_timer.time_left))
	
	if following:
		get_window().position += Vector2i(get_global_mouse_position()) - Vector2i(dragging_start_position)

func _on_close_button_pressed():
	get_tree().quit()


func _on_minimize_button_pressed():
	get_window().mode = 1

func _on_start_button_pressed():
	start_state_timer()
	$start_button.visible = false
	$stop_button.visible = true
	
func _on_stop_button_pressed():
	stop_state_timer()
	$start_button.visible = true
	$stop_button.visible = false

func start_state_timer():
	if state == "focus":
		$timers/focus_timer.start()
	elif state == "short_break":
		$timers/short_break_timer.start()
	elif state == "long_break":
		$timers/short_break_timer.start()

func stop_state_timer():
	if state == "focus":
		Global.focus_time = state_timer.time_left
		print(Global.focus_time)
		$timers/focus_timer.stop()
	elif state == "short_break":
		Global.short_break_time = state_timer.time_left
		$timers/short_break_timer.stop()
	elif state == "long_break":
		Global.long_break_time = state_timer.time_left
		$timers/long_break_timer.stop()
	print(Global.focus_time)
	Global.save_data()
	print(Global.focus_time)
