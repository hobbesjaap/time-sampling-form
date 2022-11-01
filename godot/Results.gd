extends CanvasLayer


onready var global_ints = $"/root/GlobalInts"


func _ready():
	pass


func Download_File(_img,_filename):
	var buf = _img.save_png_to_buffer()
	JavaScript.download_buffer(buf,_filename+".png")


func _on_SaveReport_pressed():
#	Download_File(results, results)
	pass


func _on_BackMainMenu_pressed():
	global_ints.reset_all_vars()
	var _ignore = get_tree().reload_current_scene()


func _on_Results_visibility_changed():
	if global_ints.generate_results == true:
		global_ints.generate_results = false
		var result_text : String
		result_text = str("wins: ", global_ints.five_behaviour_score , " Losses: ", global_ints.two_behaviour_score, " blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah ")
		result_text = str("Date: xx-xx-xxxx \nTime: X to X \n \nThis Time Sampling Form (TSF) observation was completed by %T. %S was observed for %time minutes during %AL. \n \nDuring the observation, OBS1 was observed x out of x times, resulting in xx%. OBS2 was observed x out of x times, resulting in xx%. OBS3 was observed x out of x times, resulting in xx%. OBS4 was observed x out of x times, resulting in xx%. OBS5 was observed x out of x times, resulting in xx%. xx intervals were not scored.")
		result_text = str("Date: xx-xx-xxxx \nTime: ", global_ints.observation_start_time , " to " , global_ints.observation_end_time , "\n \nThis Time Sampling Form (TSF) observation was completed by %T. %S was observed for %time minutes during %AL. \n \nDuring the observation, OBS1 was observed x out of x times, resulting in xx%. OBS2 was observed x out of x times, resulting in xx%. OBS3 was observed x out of x times, resulting in xx%. OBS4 was observed x out of x times, resulting in xx%. OBS5 was observed x out of x times, resulting in xx%. xx intervals were not scored.")
		$"%FullResult".text = result_text
