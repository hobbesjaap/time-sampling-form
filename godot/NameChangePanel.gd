extends Panel


func _on_OkButton_pressed() -> void:
	if $"%NameLine".text and $"NameContainer/ObserverLine".text and $"NameContainer/ObservedActivity".text != "":
		$"%InstructionPanel".show()
		$"%NameChangePanel".hide()
		global_ints.observed_person_name = $"%NameLine".text
		global_ints.observer_person_name = $"NameContainer/ObserverLine".text
		global_ints.observed_activity = $"NameContainer/ObservedActivity".text
	else:
		$"%ObservedNameLabel".hide()
		$"%WarningLabel".show()
