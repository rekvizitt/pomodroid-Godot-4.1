extends Control

# variable is used in the logic of moving the window 
var following = false

var dragging_start_position = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
