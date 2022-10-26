extends Node

# For testing purposes - make the intervals 4 seconds instead of 20

var timer_duration : int = 4

var observation_minutes : int = 1

var observed_person_name : String

var locked_observation_minutes : int
var locked_observation_intervals : int
var locked_observations_intervals_remaining : int

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
var four_behaviour_score: int
var five_behaviour_score : int
var six_behaviour_score : int
