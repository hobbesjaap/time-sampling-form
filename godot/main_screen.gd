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

var check_time_var : int
var csv_url = "https://raw.githubusercontent.com/hobbesjaap/time-sampling-form/main/updater/version_info.csv"
var update_text_url = "https://raw.githubusercontent.com/hobbesjaap/time-sampling-form/main/updater/update_text.md"
var update_text : String
var text_buffer : String
var os_list : Array = ["Linux", "Windows", "macOS", "OSX", "UWP", "X11", "FreeBSD", "NetBSD", "OpenBSD", "BSD"]

var test_sound = preload("res://Assets/audio/time_to_score.ogg")

@onready var minute_label = $"StartScreen/InstructionPanel/MinuteBox/MinuteLabel"
@onready var styleBox_highlight : StyleBoxFlat = $"%OneInstrPanel".get_theme_stylebox("panel").duplicate()
@onready var styleBox_orig : StyleBoxFlat = $"%TwoNamesPanel".get_theme_stylebox("panel").duplicate()


func check_for_updates() -> void:
	if os_list.has(OS.get_name()):
#		print("We're on desktop. So let's check for updates!")
		$"%HTTPRequest".request(csv_url)
		$"%HTTPRequest2".request(update_text_url)


func _on_HTTPRequest_request_completed(_result, _response_code, _headers, body) -> void:
	var test_json_conv = JSON.new()
	test_json_conv.parse(body.get_string_from_utf8())
	var json = test_json_conv.get_data()
	global_ints.web_release_version = json
	if global_ints.web_release_version > global_ints.release_version:
			print("There's an update!")
			$"%UpdatePanel".visible = true
			$"%UpdateText".text = str(update_text)
			$"%UpdateIntro".text = str("You are currently using version ",global_ints.release_version,". The latest version available is ",global_ints.web_release_version,".")
	if global_ints.web_release_version <= global_ints.release_version:
		print("No update available!")


func _on_HTTPRequest2_request_completed(_result, _response_code, _headers, body) -> void:
	var test_json_conv = JSON.new()
	test_json_conv.parse(body.get_string_from_utf8())
	var json = test_json_conv.get_data()
	global_ints.update_text = str(json)


func refresh_descriptors() -> void:
	$"%1Acronym".text = global_ints.one_acronym
	$"%1AcronymE".text = $"%1Acronym".text
	$"%2Acronym".text = global_ints.two_acronym
	$"%2AcronymE".text = $"%2Acronym".text
	$"%3Acronym".text = global_ints.three_acronym
	$"%3AcronymE".text = $"%3Acronym".text
	$"%4Acronym".text = global_ints.four_acronym
	$"%4AcronymE".text = $"%4Acronym".text
	$"%5Acronym".text = global_ints.five_acronym
	$"%5AcronymE".text = $"%5Acronym".text
	$"%1Item".text = global_ints.one_behaviour
	$"%1ItemE".text = $"%1Item".text
	$"%2Item".text = global_ints.two_behaviour
	$"%2ItemE".text = $"%2Item".text
	$"%3Item".text = global_ints.three_behaviour
	$"%3ItemE".text = $"%3Item".text
	$"%4Item".text = global_ints.four_behaviour
	$"%4ItemE".text = $"%4Item".text
	$"%5Item".text = global_ints.five_behaviour
	$"%5ItemE".text = $"%5Item".text
	$"%1Explanation".text = global_ints.one_explanation
	$"%1ExplanationE".text = $"%1Explanation".text
	$"%2Explanation".text = global_ints.two_explanation
	$"%2ExplanationE".text = $"%2Explanation".text
	$"%3Explanation".text = global_ints.three_explanation
	$"%3ExplanationE".text = $"%3Explanation".text
	$"%4Explanation".text = global_ints.four_explanation
	$"%4ExplanationE".text = $"%4Explanation".text
	$"%5Explanation".text = global_ints.five_explanation
	$"%5ExplanationE".text = $"%5Explanation".text


func set_language() -> void:
	print(TranslationServer.get_locale())
	if TranslationServer.get_locale() != "nl":
		print("We're not Dutch")
		#global_ints.manual_url = "https://docs.jaapmarsman.com/tsf.html"
	if TranslationServer.get_locale() == "nl":
		print("We're Dutch")
		#global_ints.manual_url = "https://www.lerenleukermaken.nl/"


func update_date() -> void:
	global_ints.date = Time.get_datetime_dict_from_system()
	global_ints.ddmmyyyy = str(global_ints.date.day, "-", global_ints.date.month, "-", global_ints.date.year)


func set_app_window_size() -> void:
	var desktop_x : int = DisplayServer.screen_get_size(DisplayServer.window_get_current_screen()).x
	var desktop_y : int = DisplayServer.screen_get_size(DisplayServer.window_get_current_screen()).y
	
	@warning_ignore("narrowing_conversion")
	var app_window_x : int = desktop_x * 0.7
	@warning_ignore("narrowing_conversion")
	var app_window_y : int = desktop_y * 0.7
	var app_window_size = Vector2i(app_window_x, app_window_y)
	
	DisplayServer.window_set_min_size(Vector2i(app_window_x, app_window_y))
	get_window().size = app_window_size
	@warning_ignore("integer_division")
	DisplayServer.window_set_position(Vector2i(int(desktop_x/6), int(desktop_y/6)))


func load_config_file() -> void:
	# Read config file if it exists
	# define variables from ini file
	if global_ints.err == OK:
		global_ints.first_time_starting = global_ints.config.get_value("User", "user_first_time")
	# define variables from ini file
	#	node_variables.user_name.text = user_values.user_first_name
	else:
		pass


func save_config_file() -> void:
	# All things to keep in the INI all in one place
	global_ints.config.set_value("User", "user_first_time", global_ints.first_time_starting)
	
	# Saving the actual ini
	global_ints.config.save("user://user.ini")


func _ready() -> void:
	#DisplayServer.window_set_min_size(Vector2i(1280, 720))
	if os_list.has(OS.get_name()):
		set_app_window_size()
	minute_label.text = str(global_ints.observation_minutes)
	global_ints.observed_person_name = ""
	refresh_descriptors()
	$"StartScreen".show()
	$"%InstructionScreen".hide()
	$"%InstructionPanel".hide()
	$"%NameChangePanel".hide()
	$"%WarningLabel".hide()
	$"ObservationWindow".hide()
	$"Results".hide()
	$"EditScreen".hide()
	$"%UpdatePanel".hide()
	$"SettingsMenu".hide()
	$"AboutMenu".hide()
	state_changed_check()
	update_date()
#	set_language()
	check_for_updates()
	load_config_file()
	if global_ints.first_time_starting == true:
		$"%InstructionScreen".show()
		global_ints.app_state = 1
	else:
		$"%NameChangePanel".show()
		global_ints.app_state = 2
	state_changed_check()

	$AboutMenu/VersionLabel.text = "Version " + str(global_ints.release_version_print)

	if global_ints.first_time_starting == true:
		$%ShowNextTimeButton.button_pressed = true


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


func _process(_delta) -> void:
	# When I refactor, this should move OUT of the process-delta bit
	# state_changed_check()
	pass


func _on_MinuteMinus_pressed() -> void:
	if global_ints.observation_minutes >= 2:
		global_ints.observation_minutes -= 1
		minute_label.text = str(global_ints.observation_minutes)


func _on_MinutePlus_pressed() -> void:
	if global_ints.observation_minutes < 60:
		global_ints.observation_minutes += 1
		minute_label.text = str(global_ints.observation_minutes)


func _on_Manual_pressed() -> void:
	var _error = OS.shell_open(global_ints.manual_url)


func _on_PupilName_pressed() -> void:
	$"%NameLine".text = global_ints.observed_person_name
	$"%InstructionPanel".hide()
	$"%NameChangePanel".show()
	state_changed_check()


func _on_Start_pressed() -> void:
	$"StartScreen".visible = false
	refresh_descriptors()
	$"ObservationWindow".show()
	state_changed_check()
	$"%BehaviourOne".text = global_ints.one_acronym
	$"%BehaviourTwo".text = global_ints.two_acronym
	$"%BehaviourThree".text = global_ints.three_acronym
	$"%BehaviourFour".text = global_ints.four_acronym
	$"%BehaviourFive".text = global_ints.five_acronym
	$"%BTitle1".text = global_ints.one_behaviour
	$"%BTitle2".text = global_ints.two_behaviour
	$"%BTitle3".text = global_ints.three_behaviour
	$"%BTitle4".text = global_ints.four_behaviour
	$"%BTitle5".text = global_ints.five_behaviour
	$"%ObsTitle1".text = global_ints.one_behaviour
	$"%ObsTitle2".text = global_ints.two_behaviour
	$"%ObsTitle3".text = global_ints.three_behaviour
	$"%ObsTitle4".text = global_ints.four_behaviour
	$"%ObsTitle5".text = global_ints.five_behaviour
	
	global_ints.locked_observation_minutes = global_ints.observation_minutes
	global_ints.locked_observation_intervals = global_ints.locked_observation_minutes * 3
	global_ints.locked_observations_intervals_remaining = global_ints.locked_observation_intervals
	
	$"%ObservationsTotal".text = str(global_ints.locked_observation_intervals)
	$"%ObservationsRemaining".text = str(global_ints.locked_observations_intervals_remaining)

	var obs_date_time = Time.get_datetime_dict_from_system()
	if obs_date_time.minute < 10:
		global_ints.observation_start_time = str(obs_date_time.hour, ":0", obs_date_time.minute)
	if obs_date_time.minute >= 10:
		global_ints.observation_start_time = str(obs_date_time.hour, ":", obs_date_time.minute)
	
	$"%TwentySecondTimer".start(global_ints.timer_duration)


func _on_ChangeItems_pressed() -> void:
	$"EditScreen".show()
	state_changed_check()

func _on_InsOkButton_pressed() -> void:
	save_config_file()
	global_ints.is_there_a_panel_visible = false
	$"%InstructionScreen".hide()
	state_changed_check()


func _on_MinuteMinus_button_down() -> void:
# Holding it down makes it work too - not yet
#	if global_ints.observation_minutes >= 2:
#		global_ints.observation_minutes -= 1
#		minute_label.text = str(global_ints.observation_minutes)
	pass


func _on_minute_plus_button_down() -> void:
	pass # Replace with function body.


func _on_GoToUpdate_pressed() -> void:
	var _error = OS.shell_open("https://github.com/hobbesjaap/time-sampling-form/releases")


func _on_IgnoreUpdate_pressed() -> void:
	$"%UpdatePanel".hide()


func _on_ok_button_pressed() -> void:
	if $"%NameLine".text and $"%ObserverLine".text and $"%ObservedActivity".text != "":
		$"%InstructionPanel".show()
		$"%NameChangePanel".hide()
		state_changed_check()
		global_ints.observed_person_name = $"%NameLine".text
		global_ints.observer_person_name = $"%ObserverLine".text
		global_ints.observed_activity = $"%ObservedActivity".text
		
		$"%TopOverview".text = str("Time Sampling Observation of " , global_ints.observed_person_name, ", observed by ", global_ints.observer_person_name , ", during " , global_ints.observed_activity , ".")
		$"%TopOverview".show()
	else:
		$"%ObservedNameLabel".hide()
		$"%WarningLabel".show()


func _on_edit_report_pressed() -> void:
	$"%EditResult".text = $"%FullResult".text
	$"%ResultMenu".hide()
	$"%EditPanel".show()
	$"%EditResult".show()
	$"%EditMenu".show()


func _on_cancel_edit_pressed() -> void:
	$"%ResultMenu".show()
	$"%EditPanel".hide()
	$"%EditResult".hide()
	$"%EditMenu".hide()


func _on_save_edit_pressed() -> void:
	$"%FullResult".text = $"%EditResult".text
	$"%ResultMenu".show()
	$"%EditPanel".hide()
	$"%EditResult".hide()
	$"%EditMenu".hide()


func _on_test_menu_id_pressed(id: int) -> void:
	# At some point, I'd like to add shortcuts such as Command-R or Command-Q
	# https://github.com/godotengine/godot/issues/82854
	if id == 0:
		global_ints.reset_all_vars()
		var _ignore = get_tree().reload_current_scene()
	if id == 1:
		get_tree().quit()
	if id == 2:
		$AboutMenu.show()
	if id == 3:
		$SettingsMenu.show()


func _on_test_sound_pressed() -> void:
	$SettingsMenu/AudioPlay.stream = test_sound
	$SettingsMenu/AudioPlay.play()


func _input(event) -> void:
	if global_ints.app_state != 4:
		if global_ints.is_there_a_panel_visible == false:
			if event.is_action_pressed("Settings"):
				global_ints.is_there_a_panel_visible = true
				$SettingsMenu.show()
			if event.is_action_pressed("About"):
				global_ints.is_there_a_panel_visible = true
				$AboutMenu.show()
			if event.is_action_pressed("Info"):
				global_ints.is_there_a_panel_visible = true
				$%InstructionScreen.show()
		if event.is_action_pressed("ExitMenu"):
			global_ints.is_there_a_panel_visible = false
			$SettingsMenu.hide()
			$AboutMenu.hide()
			$%InstructionScreen.hide()

func _on_close_about_menu_pressed() -> void:
	global_ints.is_there_a_panel_visible = false
	$AboutMenu.hide()


func _on_close_settings_menu_pressed() -> void:
	global_ints.is_there_a_panel_visible = false
	$SettingsMenu.hide()


func _on_show_next_time_button_toggled(toggled_on: bool) -> void:
	
	if $%ShowNextTimeButton.pressed:
		global_ints.first_time_starting = true
		save_config_file()
	if toggled_on == false:
		global_ints.first_time_starting = false
		save_config_file()
