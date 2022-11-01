extends ProgressBar


onready var global_ints = $"/root/GlobalInts"


func _ready():
	pass # Replace with function body.


func _process(_delta):
	value = global_ints.locked_observations_intervals_remaining
	max_value = global_ints.locked_observation_intervals
