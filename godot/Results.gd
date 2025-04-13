extends CanvasLayer

# Time Sampling Form

# Copyright (C) 2022-present Jaap Marsman

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.

# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

var js_interface;
var image : Image
var fileName : String = "results.png"

func _ready() -> void:
	if OS.get_name() == "Web":
		_define_js()
		js_interface = JavaScriptBridge.get_interface("_HTML5FileExchange");


func _define_js()->void:
#Define JS script
	JavaScriptBridge.eval("""
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


func take_screenshot() -> void:
	image = get_viewport().get_texture().get_image()

	if OS.get_name() == "Web" or OS.has_feature('JavaScript'):
		print("We're on the web")
		# We're on the web
		
		image.clear_mipmaps()
		
		var buffer = image.save_png_to_buffer()
		JavaScriptBridge.download_buffer(buffer, fileName)

	if OS.get_name() != "Web" or !OS.has_feature('JavaScript'):
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


func _on_SaveReport_pressed() -> void:
	await get_tree().process_frame
	$"%ResultMenu".hide()
	$"%TopMenuBar".hide()
	await get_tree().process_frame
	
	take_screenshot()
	
	$"%ResultMenu".show()
	$"%TopMenuBar".show()


func _on_BackMainMenu_pressed() -> void:
	global_ints.reset_all_vars()
	var _ignore = get_tree().reload_current_scene()


func _on_Results_visibility_changed() -> void:
	if global_ints.generate_results == true:
		global_ints.generate_results = false
		
		var result_text : String
		
		result_text = str("Observed: " , global_ints.observed_person_name , "\nDate: " , global_ints.ddmmyyyy , "\nTime: ", global_ints.observation_start_time , " to " , global_ints.observation_end_time , "\n \nThis Time Sampling Form (TSF) observation was completed by " , global_ints.observer_person_name , ". " , global_ints.observed_person_name , " was observed for " ,  global_ints.total_observed_time , " minute(s) during " , global_ints.observed_activity , ". \n \nDuring the observation, The ", global_ints.one_behaviour," behaviour was observed ", global_ints.one_behaviour_score, " out of ",global_ints.total_behaviours," times, resulting in ",global_ints.one_behaviour_percent,"%. The ",global_ints.two_behaviour," behaviour was observed ",global_ints.two_behaviour_score," out of ",global_ints.total_behaviours," times, resulting in ",global_ints.two_behaviour_percent,"%. The ",global_ints.three_behaviour," behaviour was observed ",global_ints.three_behaviour_score," out of ",global_ints.total_behaviours," times, resulting in ",global_ints.three_behaviour_percent,"%. The ", global_ints.four_behaviour," behaviour was observed ",global_ints.four_behaviour_score," out of ",global_ints.total_behaviours," times, resulting in ",global_ints.four_behaviour_percent,"%. The  ",global_ints.five_behaviour," behaviour was observed ",global_ints.five_behaviour_score," out of ",global_ints.total_behaviours," times, resulting in ",global_ints.five_behaviour_percent,"%. ",global_ints.six_behaviour_score," intervals were not scored.")
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
