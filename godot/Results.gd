extends CanvasLayer


onready var global_ints = $"/root/GlobalInts"


func _ready():
	pass

func _process(delta):
#	$"%SaveReport".visible = true
#	$"%BackMainMenu".visible = true
	pass

func _on_SaveReport_pressed():
	$"%SaveReport".visible = false
	$"%BackMainMenu".visible = false

	# WIP: Web Version
#	var file = File.new()
#	file.open("res://screenshot.png", File.READ)
#	var base_64_data = Marshalls.raw_to_base64(file.get_buffer(file.get_len()))
#	var url = "data:image/jpg;base64,"+base_64_data
#	var comand = "var a = document.createElement('a'); a.href = '" + url + "'; a.setAttribute( 'download' , 'filename.jpg' ); 	a.click();"

#	JavaScript.eval(comand, true)

	# WIP: Non-Web Version
	var image = get_viewport().get_texture().get_data()
	
	image.flip_y()
	image.save_png("user://results.png")
	

func _on_BackMainMenu_pressed():
	global_ints.reset_all_vars()
	var _ignore = get_tree().reload_current_scene()


func _on_Results_visibility_changed():
	if global_ints.generate_results == true:
		global_ints.generate_results = false

		global_ints.total_observed_time = global_ints.total_behaviours / 3

		global_ints.one_behaviour_percent = (global_ints.one_behaviour_score / global_ints.total_behaviours) * 100

		global_ints.two_behaviour_percent = (global_ints.two_behaviour_score / global_ints.total_behaviours) * 100

		global_ints.three_behaviour_percent = (global_ints.three_behaviour_score / global_ints.total_behaviours) * 100

		global_ints.four_behaviour_percent = (global_ints.four_behaviour_score / global_ints.total_behaviours) * 100

		global_ints.five_behaviour_percent = (global_ints.five_behaviour_score / global_ints.total_behaviours) * 100

		var result_text : String

		result_text = str("Date: " , global_ints.ddmmyyyy , "\nTime: ", global_ints.observation_start_time , " to " , global_ints.observation_end_time , "\n \nThis Time Sampling Form (TSF) observation was completed by " , global_ints.observer_person_name , ". " , global_ints.observed_person_name , " was observed for " ,  global_ints.total_observed_time , " minute(s) during " , global_ints.observed_activity , ". \n \nDuring the observation, The ", global_ints.one_behaviour," behaviour was observed ", global_ints.one_behaviour_score, " out of ",global_ints.total_behaviours," times, resulting in ",global_ints.one_behaviour_percent,"%. The ",global_ints.two_behaviour," behaviour was observed ",global_ints.two_behaviour_score," out of ",global_ints.total_behaviours," times, resulting in ",global_ints.two_behaviour_percent,"%. The ",global_ints.three_behaviour," behaviour was observed ",global_ints.three_behaviour_score," out of ",global_ints.total_behaviours," times, resulting in ",global_ints.three_behaviour_percent,"%. The ", global_ints.four_behaviour," behaviour was observed ",global_ints.four_behaviour_score," out of ",global_ints.total_behaviours," times, resulting in ",global_ints.four_behaviour_percent,"%. The  ",global_ints.five_behaviour," behaviour was observed ",global_ints.five_behaviour_score," out of ",global_ints.total_behaviours," times, resulting in ",global_ints.five_behaviour_percent,"%. ",global_ints.six_behaviour_score," intervals were not scored.")
		$"%FullResult".text = result_text
		
		# This is where we generate the bars
		
		$"%ObsBar1".max_value = global_ints.total_behaviours
		$"%ObsBar1".value = global_ints.one_behaviour_score
		$"%ObsBar2".max_value = global_ints.total_behaviours
		$"%ObsBar2".value = global_ints.two_behaviour_score
		$"%ObsBar3".max_value = global_ints.total_behaviours
		$"%ObsBar3".value = global_ints.three_behaviour_score
		$"%ObsBar4".max_value = global_ints.total_behaviours
		$"%ObsBar4".value = global_ints.four_behaviour_score
		$"%ObsBar5".max_value = global_ints.total_behaviours
		$"%ObsBar5".value = global_ints.five_behaviour_score
