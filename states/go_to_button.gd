extends NPCState

@export var button: Interactable
@export var button_parent: Node3D

var pathing := NPCPathingLogic.new()


func state_enter(_message: Dictionary = {}) -> void:
	pathing.set_target(button_parent)
	pathing.how_close = 2
	pathing.start_logic(self)


func state_process(_delta: float) -> void:
	if pathing.is_setup:
		pathing.process_logic()

		if pathing.is_complete:
			pathing.stop_logic()
			_press_button()


func state_exit() -> void:
	if pathing.is_setup:
		pathing.stop_logic()


func _press_button() -> void:
	await get_tree().create_timer(1.0).timeout
	button.interactable_use_start()
	await get_tree().create_timer(0.1).timeout
	button.interactable_use_stop()
	await get_tree().create_timer(1.0).timeout
	_state_machine.transition_to("Follow")


func _on_complete_path_to_button() -> void:
	_state_machine.transition_to(_state_path, {"action": "press_button"})
