extends CanvasLayer

onready var global_ints = $"/root/GlobalInts"

func _ready():
	pass # Replace with function body.


#func _process(delta):
#	pass

func Download_File(_img,_filename):
	var buf = _img.save_png_to_buffer()
	JavaScript.download_buffer(buf,_filename+".png")

func _on_SaveReport_pressed():
#	Download_File(results, results)
	pass


func _on_BackMainMenu_pressed():
	global_ints.reset_all_vars()
	var _ignore = get_tree().reload_current_scene()


func _on_Results_visibility_changed():
	if global_ints.generate_results == true:
		print("Yeah. We'll put result code here.")
		$"Panel/Obs1Text".text = str(global_ints.one_behaviour_score)
		# Code to generate the results screen - graphing, text
