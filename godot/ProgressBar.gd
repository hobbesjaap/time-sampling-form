extends ProgressBar


func _process(_delta) -> void:
	value = global_ints.locked_observations_intervals_remaining
	max_value = global_ints.locked_observation_intervals
