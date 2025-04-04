extends ProgressBar


var time_lefts : int


func _process(_delta) -> void:
	time_lefts = $"%TwentySecondTimer".time_left
	value = time_lefts
