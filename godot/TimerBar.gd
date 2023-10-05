extends ProgressBar


@onready var global_ints = $"/root/GlobalInts"

var time_lefts : int

func _ready():
	pass


func _process(_delta):
	time_lefts = $"%TwentySecondTimer".time_left
	value = time_lefts
