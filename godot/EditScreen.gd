extends CanvasLayer

onready var gi = $"/root/GlobalInts"
onready var global_ints = gi
onready var main_window = $"../../AppWindow"

func _ready():
	pass # Replace with function body.


func _on_CancelButton_pressed():
	main_window.refresh_descriptors()
	$"%EditScreen".visible = false


func _on_OKButton_pressed():
	
	global_ints.one_acronym = $"%1AcronymE".text
	global_ints.two_acronym = $"%2AcronymE".text
	global_ints.three_acronym = $"%3AcronymE".text
	global_ints.four_acronym = $"%4AcronymE".text
	global_ints.five_acronym = $"%5AcronymE".text
	
	global_ints.one_behaviour = $"%1ItemE".text
	global_ints.two_behaviour = $"%2ItemE".text
	global_ints.three_behaviour = $"%3ItemE".text
	global_ints.four_behaviour = $"%4ItemE".text
	global_ints.five_behaviour = $"%5ItemE".text
	
	global_ints.one_explanation = $"%1ExplanationE".text
	global_ints.two_explanation = $"%2ExplanationE".text
	global_ints.three_explanation = $"%3ExplanationE".text
	global_ints.four_explanation = $"%4ExplanationE".text
	global_ints.five_explanation = $"%5ExplanationE".text
		
	$"%EditScreen".visible = false
	
	main_window.refresh_descriptors()


func _on_ClearAll_pressed():
	$"%1AcronymE".text = ""
	$"%1ItemE".text = ""
	$"%1ExplanationE".text = ""
	
	$"%2AcronymE".text = ""
	$"%2ItemE".text = ""
	$"%2ExplanationE".text = ""
	
	$"%3AcronymE".text = ""
	$"%3ItemE".text = ""
	$"%3ExplanationE".text = ""
	
	$"%4AcronymE".text = ""
	$"%4ItemE".text = ""
	$"%4ExplanationE".text = ""
	
	$"%5AcronymE".text = ""
	$"%5ItemE".text = ""
	$"%5ExplanationE".text = ""
