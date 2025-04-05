extends CanvasLayer


var check_time_var : int
var csv_url = "https://raw.githubusercontent.com/hobbesjaap/time-sampling-form/main/updater/version_info.csv"
var update_text_url = "https://raw.githubusercontent.com/hobbesjaap/time-sampling-form/main/updater/update_text.md"
var update_text : String
var text_buffer : String
var os_list : Array = ["Linux", "Windows", "macOS", "OSX", "UWP", "X11", "FreeBSD", "NetBSD", "OpenBSD", "BSD"]

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
		global_ints.manual_url = "https://docs.jaapmarsman.com/tsf.html"
	if TranslationServer.get_locale() == "nl":
		print("We're Dutch")
		global_ints.manual_url = "https://www.lerenleukermaken.nl/"


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


func _ready() -> void:
	#DisplayServer.window_set_min_size(Vector2i(1280, 720))
	if os_list.has(OS.get_name()):
		set_app_window_size()
	minute_label.text = str(global_ints.observation_minutes)
	global_ints.observed_person_name = ""
	refresh_descriptors()
	$"StartScreen".show()
	$"%NameChangePanel".hide()
	$"%InstructionScreen".show()
	$"%WarningLabel".hide()
	$"ObservationWindow".hide()
	$"Results".hide()
	$"EditScreen".hide()
	$"%UpdatePanel".hide()
	state_changed_check()
	update_date()
#	set_language()
	check_for_updates()


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
	$"%InstructionScreen".hide()
	$"%NameChangePanel".show()
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
