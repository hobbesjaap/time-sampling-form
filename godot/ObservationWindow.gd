extends CanvasLayer

# Time Sampling Form

# Copyright (C) 2022-present Jaap Marsman

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.

# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

var time_lefts : int
var toggle_observation : bool = false
var observation_button_pressed : bool = false

var sound_scored = preload("res://Assets/audio/scored.ogg")
var sound_time_to_score = preload("res://Assets/audio/time_to_score.ogg")
var sound_no_score = preload("res://Assets/audio/no_score.ogg")

@onready var styleBox_highlight : StyleBoxFlat = $"%OneInstrPanel".get_theme_stylebox("panel").duplicate()
@onready var styleBox_orig : StyleBoxFlat = $"%TwoNamesPanel".get_theme_stylebox("panel").duplicate()


func set_all_boxes_to_normal() -> void:
	$"%OneInstrPanel".add_theme_stylebox_override("panel", styleBox_orig)
	$"%TwoNamesPanel".add_theme_stylebox_override("panel", styleBox_orig)
	$"%ThreeConfigPanel".add_theme_stylebox_override("panel", styleBox_orig)
	$"%FourObservePanel".add_theme_stylebox_override("panel", styleBox_orig)
	$"%FiveResultsPanel".add_theme_stylebox_override("panel", styleBox_orig)


func state_changed_check() -> void:
	styleBox_highlight.set("bg_color", Color.html("#F2CC8F"))

	if $"%InstructionScreen".visible == true:
		global_ints.app_state = 1
		set_all_boxes_to_normal()
		$"%OneInstrPanel".add_theme_stylebox_override("panel", styleBox_highlight)

	if $"%NameChangePanel".visible == true:
		global_ints.app_state = 2
		set_all_boxes_to_normal()
		$"%TwoNamesPanel".add_theme_stylebox_override("panel", styleBox_highlight)
		
	if $"%InstructionPanel".visible == true:
		global_ints.app_state = 3
		set_all_boxes_to_normal()
		$"%ThreeConfigPanel".add_theme_stylebox_override("panel", styleBox_highlight)

	if $"%ObservationWindow".visible == true:
		global_ints.app_state = 4
		set_all_boxes_to_normal()
		$"%FourObservePanel".add_theme_stylebox_override("panel", styleBox_highlight)

	if $"%Results".visible == true:
		global_ints.app_state = 5
		set_all_boxes_to_normal()
		$"%FiveResultsPanel".add_theme_stylebox_override("panel", styleBox_highlight)


func _ready() -> void:
	$"Panel/BehaviourButtons".hide()
	$TwentySecondTimer.set_wait_time(global_ints.timer_duration)


func _process(_delta) -> void:
	time_lefts = $"TwentySecondTimer".time_left
	$"Panel/TimeRemaining".text = str(time_lefts)
	if time_lefts == 5 && toggle_observation == false:
		print("We're at the five second mark!")
		toggle_observation = true
		$"Panel/BehaviourButtons".show()
		$AudioPlayer.stream = sound_time_to_score
		$AudioPlayer.play()


func calculate_percentages() -> void:
		@warning_ignore("integer_division")
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
		$AudioPlayer.stream = sound_no_score
		$AudioPlayer.play()
	
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
	$AudioPlayer.stream = sound_scored
	$AudioPlayer.play()
	$"Panel/BehaviourButtons".hide()
	print(str(global_ints.one_behaviour_score))


func _on_BehaviourTwo_pressed() -> void:
	global_ints.two_behaviour_score += 1
	global_ints.total_behaviours += 1
	observation_button_pressed = true
	$AudioPlayer.stream = sound_scored
	$AudioPlayer.play()
	$"Panel/BehaviourButtons".hide()


func _on_BehaviourThree_pressed() -> void:
	global_ints.three_behaviour_score += 1
	global_ints.total_behaviours += 1
	observation_button_pressed = true
	$AudioPlayer.stream = sound_scored
	$AudioPlayer.play()
	$"Panel/BehaviourButtons".hide()


func _on_BehaviourFour_pressed() -> void:
	global_ints.four_behaviour_score += 1
	global_ints.total_behaviours += 1
	observation_button_pressed = true
	$AudioPlayer.stream = sound_scored
	$AudioPlayer.play()
	$"Panel/BehaviourButtons".hide()


func _on_BehaviourFive_pressed() -> void:
	global_ints.five_behaviour_score += 1
	global_ints.total_behaviours += 1
	observation_button_pressed = true
	$AudioPlayer.stream = sound_scored
	$AudioPlayer.play()
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
	$"%ObservationWindow".hide()
	$"../Results".show()
	state_changed_check()


func _input(event) -> void:
	if event.is_action_pressed("BehaviourOne"):
		print("One")
		if toggle_observation == true:
			_on_BehaviourOne_pressed()
	if event.is_action_pressed("BehaviourTwo"):
		print("Two")
		if toggle_observation == true:
			_on_BehaviourTwo_pressed()
	if event.is_action_pressed("BehaviourThree"):
		print("Three")
		if toggle_observation == true:
			_on_BehaviourThree_pressed()
	if event.is_action_pressed("BehaviourFour"):
		print("Four")
		if toggle_observation == true:
			_on_BehaviourFour_pressed()
	if event.is_action_pressed("BehaviourFive"):
		print("Five")
		if toggle_observation == true:
			_on_BehaviourFive_pressed()
