extends Node

var date = {}
var ddmmyyyy : String

# 1 = Instruction, 2 = Names, 3 = Config, 4 = Observe, 5 = Results
var app_state : int

var update_text : String

var web_release_version : float
var release_version = 0.2

var total_observed_time : int

var timer_duration : float = 20.0

var observation_minutes : int = 10

var observation_start_time : String
var observation_end_time : String

var generate_results : bool = false

var manual_url : String

var observed_person_name : String
var observer_person_name : String
var observed_activity : String

var locked_observation_minutes : int
var locked_observation_intervals : int
var locked_observations_intervals_remaining : int
var locked_observations_completed : int

var one_acronym : String = "OnT"
var two_acronym : String = "Loo"
var three_acronym : String = "Dis"
var four_acronym : String = "Wal"
var five_acronym : String = "Oth"
var six_acronym : String = "Emp"

var one_behaviour : String = "On Task"
var two_behaviour : String = "Looking"
var three_behaviour : String = "Distracting"
var four_behaviour : String = "Walking"
var five_behaviour : String = "Other"
var six_behaviour : String = "Empty"

var one_explanation : String = "The pupil is on task"
var two_explanation : String = "The pupil is looking around in a distracted manner or is staring into the distance"
var three_explanation : String = "The pupil is distracting other pupils or talking to them"
var four_explanation : String = "The pupil is walking through the class"
var five_explanation : String = "The pupil is otherwise distracted and not on task"
var six_explanation : String = "No answer was selected for this round"

var total_behaviours : int
var one_behaviour_score : int
var two_behaviour_score : int
var three_behaviour_score : int
var four_behaviour_score : int
var five_behaviour_score : int
var six_behaviour_score : int

var one_behaviour_percent : float
var two_behaviour_percent : float
var three_behaviour_percent : float
var four_behaviour_percent : float
var five_behaviour_percent : float

func reset_all_vars() -> void:
	observation_minutes = 10

	generate_results = false

	observed_person_name = ""
	observer_person_name = ""
	observed_activity = ""

	locked_observation_minutes = 0
	locked_observation_intervals = 0
	locked_observations_intervals_remaining = 0
	locked_observations_completed = 0

	one_acronym = "OnT"
	two_acronym = "Loo"
	three_acronym = "Dis"
	four_acronym = "Wal"
	five_acronym = "Oth"
	six_acronym = "Emp"

	one_behaviour = "On Task"
	two_behaviour = "Looking"
	three_behaviour = "Distracting"
	four_behaviour = "Walking"
	five_behaviour = "Other"
	six_behaviour = "Empty"

	one_explanation = "The pupil is on task"
	two_explanation = "The pupil is looking around in a distracted manner or is staring into the distance"
	three_explanation = "The pupil is distracting other pupils or talking to them"
	four_explanation = "The pupil is walking through the class"
	five_explanation = "The pupil is otherwise distracted and not on task"
	six_explanation = "No answer was selected for this round"

	total_behaviours = 0
	one_behaviour_score = 0
	two_behaviour_score = 0
	three_behaviour_score = 0
	four_behaviour_score = 0
	five_behaviour_score = 0
	six_behaviour_score = 0

	one_behaviour_percent = 0.0
	two_behaviour_percent = 0.0
	three_behaviour_percent = 0.0
	four_behaviour_percent = 0.0
	five_behaviour_percent = 0.0
	
	observation_start_time = ""
	observation_end_time = ""

	date = ""
	
	ddmmyyyy = ""

	total_observed_time = 0
	
	timer_duration = 20.0
