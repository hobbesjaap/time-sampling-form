extends CanvasLayer


onready var global_ints = $"/root/GlobalInts"

var js_callback = JavaScript.create_callback(self, "load_handler");
var js_interface;
var image : Image
var fileName : String = "results.png"

func _ready():
	if OS.get_name() == "HTML5" and OS.has_feature('JavaScript'):
		_define_js()
		js_interface = JavaScript.get_interface("_HTML5FileExchange");


func _define_js()->void:
	#Define JS script
	JavaScript.eval("""
	var _HTML5FileExchange = {};
	_HTML5FileExchange.upload = function(gd_callback) {
		canceled = true;
		var input = document.createElement('INPUT'); 
		input.setAttribute("type", "file");
		input.setAttribute("accept", "image/png, image/jpeg, image/webp");
		input.click();
		input.addEventListener('change', event => {
			if (event.target.files.length > 0){
				canceled = false;}
			var file = event.target.files[0];
			var reader = new FileReader();
			this.fileType = file.type;
			// var fileName = file.name;
			reader.readAsArrayBuffer(file);
			reader.onloadend = (evt) => { // Since here's it's arrow function, "this" still refers to _HTML5FileExchange
				if (evt.target.readyState == FileReader.DONE) {
					this.result = evt.target.result;
					gd_callback(); // It's hard to retrieve value from callback argument, so it's just for notification
				}
			}
		  });
	}
	""", true)


func _process(_delta):
#	$"%SaveReport".visible = true
#	$"%BackMainMenu".visible = true
	pass

func _on_SaveReport_pressed():
	$"%SaveReport".visible = false
	$"%BackMainMenu".visible = false

	print("I've disabled the buttons")
	print("That means the screenshot SHOULD be button free")

	image = get_viewport().get_texture().get_data()
	image.flip_y()

	if OS.get_name() == "HTML5" or OS.has_feature('JavaScript'):
		# We're on the web
		print("We're on the web")
	
		image.clear_mipmaps()
		var buffer = image.save_png_to_buffer()
		JavaScript.download_buffer(buffer, fileName)

	if OS.get_name() != "HTML5" or !OS.has_feature('JavaScript'):
		# We're not on the web
		print("We're not on the web")
		
		var docs = OS.get_environment("HOME") + "/Documents"
		
		var title = str(docs + "/results",global_ints.observed_person_name, global_ints.observation_minutes,".png")
		
		print(title)
		
		var _saveimage = image.save_png(title)
		
		if OS.get_name() != "OSX":
			print("We're not on MacOS")
			var _openfolder = OS.shell_open(docs)
		
		if OS.get_name() == "OSX":
			print("We're on MacOS")
			
			var _openfolder = OS.shell_open("file://" + docs)
		
	$"%SaveReport".visible = true
	$"%BackMainMenu".visible = true

func _on_BackMainMenu_pressed():
	global_ints.reset_all_vars()
	var _ignore = get_tree().reload_current_scene()


func _on_Results_visibility_changed():
	if global_ints.generate_results == true:
		global_ints.generate_results = false

		var result_text : String

		result_text = str("Date: " , global_ints.ddmmyyyy , "\nTime: ", global_ints.observation_start_time , " to " , global_ints.observation_end_time , "\n \nThis Time Sampling Form (TSF) observation was completed by " , global_ints.observer_person_name , ". " , global_ints.observed_person_name , " was observed for " ,  global_ints.total_observed_time , " minute(s) during " , global_ints.observed_activity , ". \n \nDuring the observation, The ", global_ints.one_behaviour," behaviour was observed ", global_ints.one_behaviour_score, " out of ",global_ints.total_behaviours," times, resulting in ",global_ints.one_behaviour_percent,"%. The ",global_ints.two_behaviour," behaviour was observed ",global_ints.two_behaviour_score," out of ",global_ints.total_behaviours," times, resulting in ",global_ints.two_behaviour_percent,"%. The ",global_ints.three_behaviour," behaviour was observed ",global_ints.three_behaviour_score," out of ",global_ints.total_behaviours," times, resulting in ",global_ints.three_behaviour_percent,"%. The ", global_ints.four_behaviour," behaviour was observed ",global_ints.four_behaviour_score," out of ",global_ints.total_behaviours," times, resulting in ",global_ints.four_behaviour_percent,"%. The  ",global_ints.five_behaviour," behaviour was observed ",global_ints.five_behaviour_score," out of ",global_ints.total_behaviours," times, resulting in ",global_ints.five_behaviour_percent,"%. ",global_ints.six_behaviour_score," intervals were not scored.")
		$"%FullResult".text = result_text
		
		# This is where we generate the bars
		
		$"%ObsBar1".max_value = global_ints.total_behaviours
		$"%ObsBar1".value = global_ints.one_behaviour_score
		$"%ObsBar2".max_value = global_ints.total_behaviours
		$"%ObsBar2".value = global_ints.two_behaviour_score
		$"%ObsBar3".max_value = global_ints.total_behaviours
		$"%ObsBar3".value = global_ints.three_behaviour_score
		$"%ObsBar4".max_value = global_ints.total_behaviours
		$"%ObsBar4".value = global_ints.four_behaviour_score
		$"%ObsBar5".max_value = global_ints.total_behaviours
		$"%ObsBar5".value = global_ints.five_behaviour_score
