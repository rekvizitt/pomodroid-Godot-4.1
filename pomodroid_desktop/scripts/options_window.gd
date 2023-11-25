extends Control

# variable is used in the logic of moving the window 
var following = false

var dragging_start_position = Vector2()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_values()
	# moving boardless window
	if following:
		get_window().position += Vector2i(get_global_mouse_position()) - Vector2i(dragging_start_position)

func _on_titlebar_gui_input(event):
	if event is InputEventMouseButton:
		if event.get_button_index() == 1:
			following = !following
			dragging_start_position = get_local_mouse_position()

# close button logic
func _on_close_button_pressed():
	get_tree().quit()

# minimize button logic
func _on_minimize_button_pressed():
	get_window().mode = 1


func _on_focus_slider_value_changed(value):
	$focus_value.text = str(value) + " : 00"
	# time in seconds
	Global.data["focus_time"] = value * 60
	# save new data
	Global.save_data()

func set_values():
	$focus_value.text = str(Global.data["focus_time"] / 60) + " : 00"
	$focus_slider.value = Global.data["focus_time"] / 60
	$short_break_value.text = str(Global.data["short_break_time"] / 60) + " : 00"
	$short_break_slider.value = Global.data["short_break_time"] / 60
	$long_break_value.text = str(Global.data["long_break_time"] / 60) + " : 00"
	$long_break_slider.value = Global.data["long_break_time"] / 60
	$rounds_value.text = str(Global.data["rounds"])
	$rounds_slider.value = Global.data["rounds"]

func _on_short_break_slider_value_changed(value):
	$short_break_value.text = str(value) + " : 00"
	# time in seconds
	Global.data["short_break_time"] = value * 60
	# save new data
	Global.save_data()

func _on_long_break_slider_value_changed(value):
	$long_break_value.text = str(value) + " : 00"
	# time in seconds
	Global.data["long_break_time"] = value * 60
	# save new data
	Global.save_data()

func _on_set_default_button_pressed():
	Global.data["focus_time"] = 1800
	Global.data["short_break_time"] = 300
	Global.data["long_break_time"] = 900
	Global.data["rounds"] = 3
	Global.save_data()


func _on_rounds_slider_value_changed(value):
	$rounds_value.text = str(value)
	# time in seconds
	Global.data["rounds"] = value
	# save new data
	Global.save_data()
