extends Panel


onready var global_ints = $"/root/GlobalInts"


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_OkButton_pressed() -> void:
	if $"%NameLine".text != "":
		$"%InstructionPanel".visible = true
		$"%NameChangePanel".visible = false
		global_ints.observed_person_name = $"%NameLine".text
	else:
		$"%ObservedNameLabel".visible = false
		$"%WarningLabel".visible = true
