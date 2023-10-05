extends CanvasLayer

const RATIO = 720.0 / 1280.0

var date_time
var check_time_var : int
var ddmmyyyy : String
var date
var csv_url = "https://gitea.defiantjc.synology.me/jaap/time-sampling-form/raw/branch/main/version_info.csv"
var update_text_url = "https://gitea.defiantjc.synology.me/jaap/time-sampling-form/raw/branch/main/updater/update_text.md"
var update_text : String


@onready var date_time_display = $"%CurrentTime"
@onready var global_ints = $"/root/GlobalInts"
@onready var minute_label = $"StartScreen/InstructionPanel/MinuteBox/MinuteLabel"


#func set_window_aspect_ratio():
#	OS.window_size = Vector2(OS.window_size.x, OS.window_size.x * RATIO)
#	var screen_size = DisplayServer.screen_get_size()
#	var window = get_editor_interface().get_window()
#	window.mode = Window.MODE_WINDOWED
#	window.position = Vector2i(-8, 0)
#	window.size = Vector2i(screen_size.x - 66, screen_size.y - 1)

func check_for_updates():
	var os_check : String
	os_check = OS.get_name()
	print(os_check)
	if os_check == "Linux" and "Windows" and "OSX":
		print("We're on desktop. So let's check for updates!")
		$"%HTTPRequest".request(csv_url)
		$"%HTTPRequest2".request(update_text_url)


func _on_HTTPRequest_request_completed(_result, _response_code, _headers, body):
	var test_json_conv = JSON.new()
	test_json_conv.parse(body.get_string_from_utf8())
	var json = test_json_conv.get_data()
	global_ints.web_release_version = json
	if global_ints.web_release_version > global_ints.release_version:
			print("There's an update!")
			$"%UpdatePanel".visible = true
			$"%UpdateText".text = str(update_text)
			$"%UpdateIntro".text = str("You are currently using version ",global_ints.release_version,". The latest version available is ",global_ints.web_release_version,".")


func _on_HTTPRequest2_request_completed(_result, _response_code, _headers, _body):
#	Need to find a way to load .txt file contents from a URL into a label. This to show what the update changes are.
#	var json = JSON.parse(body.get_string_from_utf8())
#	update_text = str(json.result)
	pass


func refresh_descriptors():
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

func set_manual_url():
	if TranslationServer.get_locale() != "nl":
		print("We're not Dutch")
		global_ints.manual_url = "https://docs.internationalsengroup.org/tsf.html"
	if TranslationServer.get_locale() == "nl":
		print("We're Dutch")
		global_ints.manual_url = "https://www.lerenleukermaken.nl/"

func _ready():
	DisplayServer.window_set_min_size(Vector2i(1280, 720))
	minute_label.text = str(global_ints.observation_minutes)
	global_ints.observed_person_name = ""
	refresh_descriptors()
	$"StartScreen".visible = true
	$"%NameChangePanel".visible = true
	$"%InstructionScreen".visible = true
	$"%WarningLabel".visible = false
	$"ObservationWindow".visible = false
	$"Results".visible = false
	$"EditScreen".visible = false
	$"%UpdatePanel".visible = false
	set_manual_url()
	print(TranslationServer.get_locale())
	
	global_ints.date = Time.get_datetime_dict_from_system()
	global_ints.ddmmyyyy = str(global_ints.date.day, "-", global_ints.date.month, "-", global_ints.date.year)
	
	check_for_updates()

func _process(_delta):
	check_time_var += 1
	
	if check_time_var == 10:
		check_time_var = 0
		date_time = Time.get_datetime_dict_from_system()
		if date_time.minute < 10:
			date_time_display.text = str(date_time.hour, ":0", date_time.minute)
		if date_time.minute >= 10:
			date_time_display.text = str(date_time.hour, ":", date_time.minute)


func _on_MinuteMinus_pressed():
	if global_ints.observation_minutes >= 2:
		global_ints.observation_minutes -= 1
		minute_label.text = str(global_ints.observation_minutes)


func _on_MinutePlus_pressed():
	if global_ints.observation_minutes < 60:
		global_ints.observation_minutes += 1
		minute_label.text = str(global_ints.observation_minutes)


func _on_Manual_pressed():
	var _error = OS.shell_open(global_ints.manual_url)


func _on_PupilName_pressed():
	$"%NameLine".text = global_ints.observed_person_name
	$"%InstructionPanel".visible = false
	$"%NameChangePanel".visible = true


func _on_Start_pressed():
	$"StartScreen".visible = false
	refresh_descriptors()
	$"ObservationWindow".visible = true
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


func _on_ChangeItems_pressed():
	$"EditScreen".visible = true


func _on_InsOkButton_pressed():
	$"%InstructionScreen".visible = false


func _on_MinuteMinus_button_down():
#	if global_ints.observation_minutes >= 2:
#		global_ints.observation_minutes -= 1
#		minute_label.text = str(global_ints.observation_minutes)
	pass


func _on_GoToUpdate_pressed():
	var _error = OS.shell_open("https://github.com/hobbesjaap/time-sampling-form/releases")


func _on_IgnoreUpdate_pressed():
	$"%UpdatePanel".visible = false
