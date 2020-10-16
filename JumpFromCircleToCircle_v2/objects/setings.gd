extends Node

var enable_sound = true
var hiscore
var settings_file = "user://settingd.save"

func save_settings():
	var f = File.new()
	f.open(settings_file, File.WRITE)
	f.store_var(hiscore)
	f.store_var(enable_sound)
	f.close()

func load_settings():
	var f = File.new()
	if f.file_exists(settings_file):
		f.open(settings_file, File.READ)
		enable_sound = f.get_var()
		hiscore = f.get_var()
		f.close()
