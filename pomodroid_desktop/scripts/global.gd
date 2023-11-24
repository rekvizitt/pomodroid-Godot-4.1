extends Node

# store app values
var data
# base values
var focus_time = 1800 # 60..5400
var short_break_time = 300 # 60..5400
var long_break_time = 900 # 60..5400
var rounds = 3 # 0..11

var state = "focus" # focus, short_break, long_break

func _ready():
	load_data()
	var data = {
		"focus_time" : focus_time,
		"short_break_time": short_break_time,
		"long_break_time": long_break_time,
		"rounds": rounds,
		"state": state
	}
	

# save data to file 
func save_data():
	data = {
		"focus_time" : focus_time,
		"short_break_time": short_break_time,
		"long_break_time": long_break_time,
		"rounds": rounds,
		"state": state
	}
	var file = FileAccess.open("user://data.dat", FileAccess.WRITE)
	file.store_var(data)
	file.close()

# load data from file
func load_data():
	if FileAccess.file_exists("user://data.dat"):
		var file = FileAccess.open("user://data.dat", FileAccess.READ)
		data = file.get_var()
		file.close()
	else:
		data = {
		"focus_time" : focus_time,
		"short_break_time": short_break_time,
		"long_break_time": long_break_time,
		"rounds": rounds,
		"state": state
		}
