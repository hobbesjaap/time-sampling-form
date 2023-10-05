extends Panel


@onready var global_ints = $"/root/GlobalInts"


func _on_OkButton_pressed():
	if $"%NameLine".text and $"NameContainer/ObserverLine".text and $"NameContainer/ObservedActivity".text != "":
		$"%InstructionPanel".visible = true
		$"%NameChangePanel".visible = false
		global_ints.observed_person_name = $"%NameLine".text
		global_ints.observer_person_name = $"NameContainer/ObserverLine".text
		global_ints.observed_activity = $"NameContainer/ObservedActivity".text
	else:
		$"%ObservedNameLabel".visible = false
		$"%WarningLabel".visible = true
