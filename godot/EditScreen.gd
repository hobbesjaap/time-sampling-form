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

@onready var main_window = $"../../AppWindow"


func _on_CancelButton_pressed() -> void:
	main_window.refresh_descriptors()
	$"%EditScreen".visible = false


func _on_OKButton_pressed() -> void:
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
		
	$"%EditScreen".hide()
	
	main_window.refresh_descriptors()


func _on_ClearAll_pressed() -> void:
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
