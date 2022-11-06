extends Node

var date
var ddmmyyyy

var web_release_version = 0
var release_version = 1

var total_observed_time : int

var timer_duration : int = 6

var observation_minutes : int = 1

var observation_start_time : String
var observation_end_time : String

var generate_results : bool = false

var observed_person_name : String
var observer_person_name : String
var observed_activity : String

var locked_observation_minutes : int
var locked_observation_intervals : int
var locked_observations_intervals_remaining : int
var locked_observations_completed : int

var one_acronym = "OnT"
var two_acronym = "Loo"
var three_acronym = "Dis"
var four_acronym = "Wal"
var five_acronym = "Oth"
var six_acronym = "Emp"

var one_behaviour = "On Task"
var two_behaviour = "Looking"
var three_behaviour = "Distracting"
var four_behaviour = "Walking"
var five_behaviour = "Other"
var six_behaviour = "Empty"

var one_explanation = "The pupil is on task"
var two_explanation = "The pupil is looking around in a distracted manner or is staring into the distance"
var three_explanation = "The pupil is distracting other pupils or talking to them"
var four_explanation = "The pupil is walking through the class"
var five_explanation = "The pupil is otherwise distracted and not on task"
var six_explanation = "No answer was selected for this round"

var total_behaviours : int
var one_behaviour_score : int
var two_behaviour_score : int
var three_behaviour_score : int
var four_behaviour_score : int
var five_behaviour_score : int
var six_behaviour_score : int

var one_behaviour_percent : int
var two_behaviour_percent : int
var three_behaviour_percent : int
var four_behaviour_percent : int
var five_behaviour_percent : int

func reset_all_vars():
	observation_minutes = 15

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

	one_behaviour_percent = 0
	two_behaviour_percent = 0
	three_behaviour_percent = 0
	four_behaviour_percent = 0
	five_behaviour_percent = 0
	
	observation_start_time = ""
	observation_end_time = ""

	date = ""
	
	ddmmyyyy = ""

	total_observed_time = 0
