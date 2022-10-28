extends CanvasLayer

onready var global_ints = $"/root/GlobalInts"

var time_lefts : int
var toggle_observation : bool = false
var observation_button_pressed : bool = false

func _ready():
	$"Panel/BehaviourButtons".visible = false
	pass


func _process(_delta):
	time_lefts = $"TwentySecondTimer".time_left
	$"Panel/TimeRemaining".text = str(time_lefts)
	if time_lefts == 5 && toggle_observation == false:
		print("We're at the five second mark!")
		toggle_observation = true
		$"Panel/BehaviourButtons".visible = true

func on_interval_moment():
	print("Timer reaches 0 - Let's check if buttons have been pressed and count something")
	toggle_observation = false
	# Otherwise - a 6 is registered (nothing selected)
	# Buttons are to become visible again
	global_ints.locked_observations_intervals_remaining -= 1
	$"Panel/BehaviourButtons".visible = false
	
	if observation_button_pressed == false:
		global_ints.six_behaviour_score += 1
		global_ints.total_behaviours += 1
	
	observation_button_pressed = false
	
	# The thing below here should become a graphic bar as well
	$"Panel/ObservationsRemaining".text = str(global_ints.locked_observations_intervals_remaining)

func _on_TwentySecondTimer_timeout():
	if global_ints.locked_observations_intervals_remaining == 1:
		on_interval_moment()
		print("We're completely done - no intervals remain")
		# So I should end the observation and move to the Results window.
		
		var obs_date_time = OS.get_time()
		if obs_date_time.minute < 10:
			global_ints.observation_end_time = str(obs_date_time.hour, ":0", obs_date_time.minute)
		if obs_date_time.minute >= 10:
			global_ints.observation_end_time = str(obs_date_time.hour, ":", obs_date_time.minute)

		
		$"TwentySecondTimer".stop()
		global_ints.generate_results = true
		$"../Results".visible = true
	
	if global_ints.locked_observations_intervals_remaining > 1:
		on_interval_moment()


func _on_BehaviourOne_pressed():
	global_ints.one_behaviour_score += 1
	global_ints.total_behaviours += 1
	observation_button_pressed = true
	$"Panel/BehaviourButtons".visible = false
	print(str(global_ints.one_behaviour_score))


func _on_BehaviourTwo_pressed():
	global_ints.two_behaviour_score += 1
	global_ints.total_behaviours += 1
	observation_button_pressed = true
	$"Panel/BehaviourButtons".visible = false


func _on_BehaviourThree_pressed():
	global_ints.three_behaviour_score += 1
	global_ints.total_behaviours += 1
	observation_button_pressed = true
	$"Panel/BehaviourButtons".visible = false


func _on_BehaviourFour_pressed():
	global_ints.four_behaviour_score += 1
	global_ints.total_behaviours += 1
	observation_button_pressed = true
	$"Panel/BehaviourButtons".visible = false


func _on_BehaviourFive_pressed():
	global_ints.five_behaviour_score += 1
	global_ints.total_behaviours += 1
	observation_button_pressed = true
	$"Panel/BehaviourButtons".visible = false


func _on_Button_pressed():
	on_interval_moment()
	print("We're completely done - no intervals remain")
	# So I should end the observation and move to the Results window.
	
	var obs_date_time = OS.get_time()
	if obs_date_time.minute < 10:
		global_ints.observation_end_time = str(obs_date_time.hour, ":0", obs_date_time.minute)
	if obs_date_time.minute >= 10:
		global_ints.observation_end_time = str(obs_date_time.hour, ":", obs_date_time.minute)
		
	$"TwentySecondTimer".stop()
	global_ints.generate_results = true
	$"../Results".visible = true
