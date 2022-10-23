extends CanvasLayer


var date_time
var check_time_var : int


onready var date_time_display = $"%CurrentTime"
onready var global_ints = $"/root/GlobalInts"
onready var minute_label = $"StartScreen/InstructionPanel/MinuteBox/MinuteLabel"

func refresh_descriptors():
	$"%1Acronym".text = global_ints.one_acronym
	$"%2Acronym".text = global_ints.two_acronym
	$"%3Acronym".text = global_ints.three_acronym
	$"%4Acronym".text = global_ints.four_acronym
	$"%5Acronym".text = global_ints.five_acronym
	$"%1Item".text = global_ints.one_behaviour
	$"%2Item".text = global_ints.two_behaviour
	$"%3Item".text = global_ints.three_behaviour
	$"%4Item".text = global_ints.four_behaviour
	$"%5Item".text = global_ints.five_behaviour
	$"%1Explanation".text = global_ints.one_explanation
	$"%2Explanation".text = global_ints.two_explanation
	$"%3Explanation".text = global_ints.three_explanation
	$"%4Explanation".text = global_ints.four_explanation
	$"%5Explanation".text = global_ints.five_explanation

func _ready():
	minute_label.text = str(global_ints.observation_minutes)
	global_ints.observed_person_name = ""
	refresh_descriptors()
	$"StartScreen".visible = true
	$"%NameChangePanel".visible = true
	$"%WarningLabel".visible = false
	$"ObservationWindow".visible = false
	$"Results".visible = false

func _process(_delta):
	check_time_var += 1
	
	if check_time_var == 10:
		check_time_var = 0
		date_time = OS.get_time()
		date_time_display.text = str(date_time.hour, ":", date_time.minute)


func _on_MinuteMinus_pressed() -> void:
	if global_ints.observation_minutes >= 2:
		global_ints.observation_minutes -= 1
		minute_label.text = str(global_ints.observation_minutes)


func _on_MinutePlus_pressed() -> void:
	if global_ints.observation_minutes < 60:
		global_ints.observation_minutes += 1
		minute_label.text = str(global_ints.observation_minutes)


func _on_Manual_pressed() -> void:
	var _error = OS.shell_open("https://www.internationalsengroup.org/resources/time-sampling-form/")


func _on_PupilName_pressed() -> void:
	$"%NameLine".text = global_ints.observed_person_name
	$"%InstructionPanel".visible = false
	$"%NameChangePanel".visible = true


func _on_Start_pressed() -> void:
	$"StartScreen".visible = false
	refresh_descriptors()
	$"ObservationWindow".visible = true
	$"%BehaviourOne".text = global_ints.one_acronym
	$"%BehaviourTwo".text = global_ints.two_acronym
	$"%BehaviourThree".text = global_ints.three_acronym
	$"%BehaviourFour".text = global_ints.four_acronym
	$"%BehaviourFive".text = global_ints.five_acronym
	
	global_ints.locked_observation_minutes = global_ints.observation_minutes
	global_ints.locked_observation_intervals = global_ints.locked_observation_minutes * 3
	global_ints.locked_observations_intervals_remaining = global_ints.locked_observation_intervals
	
	$"%ObservationsTotal".text = str(global_ints.locked_observation_intervals)
	$"%ObservationsRemaining".text = str(global_ints.locked_observations_intervals_remaining)
	
	$"%TwentySecondTimer".start(global_ints.timer_duration)
