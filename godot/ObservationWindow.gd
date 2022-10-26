extends CanvasLayer

onready var global_ints = $"/root/GlobalInts"

var time_lefts : int

func _ready():
	pass


func _process(_delta):
	time_lefts = $"TwentySecondTimer".time_left
	$"Panel/TimeRemaining".text = str(time_lefts)

func on_interval_moment():
	print("Timer reaches 0 - Let's check if buttons have been pressed and count something")
	# Otherwise - a 6 is registered (nothing selected)
	# Buttons are to become visible again
	global_ints.locked_observations_intervals_remaining -= 1
	# The thing below here should become a graphic bar as well
	$"Panel/ObservationsRemaining".text = str(global_ints.locked_observations_intervals_remaining)

func _on_TwentySecondTimer_timeout():
	if global_ints.locked_observations_intervals_remaining == 1:
		on_interval_moment()
		print("We're completely done - no intervals remain")
		# So I should end the observation and move to the Results window.
		$"TwentySecondTimer".stop()
		$"../Results".visible = true
	
	if global_ints.locked_observations_intervals_remaining > 1:
		on_interval_moment()
