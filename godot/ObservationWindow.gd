extends CanvasLayer


var time_lefts : int
var toggle_observation : bool = false
var observation_button_pressed : bool = false


func _ready() -> void:
	$"Panel/BehaviourButtons".hide()


func _process(_delta) -> void:
	time_lefts = $"TwentySecondTimer".time_left
	$"Panel/TimeRemaining".text = str(time_lefts)
	if time_lefts == 5 && toggle_observation == false:
		print("We're at the five second mark!")
		toggle_observation = true
		$"Panel/BehaviourButtons".show()


func calculate_percentages() -> void:
		global_ints.total_observed_time = global_ints.total_behaviours / 3

		global_ints.one_behaviour_percent = int((float(global_ints.one_behaviour_score) / global_ints.total_behaviours) * 100)

		global_ints.two_behaviour_percent = int((float(global_ints.two_behaviour_score) / global_ints.total_behaviours) * 100)

		global_ints.three_behaviour_percent = int((float(global_ints.three_behaviour_score) / global_ints.total_behaviours) * 100)

		global_ints.four_behaviour_percent = int((float(global_ints.four_behaviour_score) / global_ints.total_behaviours) * 100)

		global_ints.five_behaviour_percent = int((float(global_ints.five_behaviour_score) / global_ints.total_behaviours) * 100)

func on_interval_moment() -> void:
	print("Timer reaches 0 - Let's check if buttons have been pressed and count something")
	toggle_observation = false
	# Otherwise - a 6 is registered (nothing selected)
	# Buttons are to become visible again
	global_ints.locked_observations_intervals_remaining -= 1
	global_ints.locked_observations_completed += 1
	$"Panel/BehaviourButtons".hide()
	
	if observation_button_pressed == false:
		global_ints.six_behaviour_score += 1
		global_ints.total_behaviours += 1
	
	observation_button_pressed = false
	
	# The thing below here should become a graphic bar as well
	$"Panel/DescriptorBox/ObservationsRemaining".text = str(global_ints.locked_observations_intervals_remaining)


func _on_TwentySecondTimer_timeout() -> void:
	if global_ints.locked_observations_intervals_remaining == 1:
		on_interval_moment()
		print("We're completely done - no intervals remain")
		# So I should end the observation and move to the Results window.
		
		var obs_date_time = Time.get_datetime_dict_from_system()
		if obs_date_time.minute < 10:
			global_ints.observation_end_time = str(obs_date_time.hour, ":0", obs_date_time.minute)
		if obs_date_time.minute >= 10:
			global_ints.observation_end_time = str(obs_date_time.hour, ":", obs_date_time.minute)

		
		$"TwentySecondTimer".stop()
		global_ints.generate_results = true
		calculate_percentages()
		$"../Results".show()
	
	if global_ints.locked_observations_intervals_remaining > 1:
		on_interval_moment()


func _on_BehaviourOne_pressed() -> void:
	global_ints.one_behaviour_score += 1
	global_ints.total_behaviours += 1
	observation_button_pressed = true
	$"Panel/BehaviourButtons".hide()
	print(str(global_ints.one_behaviour_score))


func _on_BehaviourTwo_pressed() -> void:
	global_ints.two_behaviour_score += 1
	global_ints.total_behaviours += 1
	observation_button_pressed = true
	$"Panel/BehaviourButtons".hide()


func _on_BehaviourThree_pressed() -> void:
	global_ints.three_behaviour_score += 1
	global_ints.total_behaviours += 1
	observation_button_pressed = true
	$"Panel/BehaviourButtons".hide()


func _on_BehaviourFour_pressed() -> void:
	global_ints.four_behaviour_score += 1
	global_ints.total_behaviours += 1
	observation_button_pressed = true
	$"Panel/BehaviourButtons".hide()


func _on_BehaviourFive_pressed() -> void:
	global_ints.five_behaviour_score += 1
	global_ints.total_behaviours += 1
	observation_button_pressed = true
	$"Panel/BehaviourButtons".hide()


func _on_Button_pressed() -> void:
	on_interval_moment()
	print("We're aborting, so deal with as completely done - no intervals remain")
	
	# This to set the original total count to what's actually been completed
	global_ints.locked_observation_intervals = global_ints.locked_observations_completed
	# So I should end the observation and move to the Results window.
	
	var obs_date_time = Time.get_datetime_dict_from_system()
	if obs_date_time.minute < 10:
		global_ints.observation_end_time = str(obs_date_time.hour, ":0", obs_date_time.minute)
	if obs_date_time.minute >= 10:
		global_ints.observation_end_time = str(obs_date_time.hour, ":", obs_date_time.minute)
		
	$"TwentySecondTimer".stop()
	global_ints.generate_results = true
	calculate_percentages()
	$"../Results".show()
