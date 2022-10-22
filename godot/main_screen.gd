extends CanvasLayer


var date_time
var check_time_var : int


onready var date_time_display = $"%CurrentTime"
onready var global_ints = $"/root/GlobalInts"
onready var minute_label = $"StartScreen/InstructionPanel/MinuteBox/MinuteLabel"


func _ready():
	minute_label.text = str(global_ints.observation_minutes)
	global_ints.observed_person_name = ""
	$"%NameChangePanel".visible = false
	$"%WarningLabel".visible = false


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
