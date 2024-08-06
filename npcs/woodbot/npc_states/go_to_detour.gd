extends NPCState

var _pathing := NPCPathingLogic.new()


func state_enter(_message: Dictionary = {}) -> void:
	# If we don't know about any detours, go to the lighthouse
	var detours := WoodbotUtils.find_detours(get_tree())
	if detours.size() == 0:
		_state_machine.transition_to("GoToLighthouse")
		return

	# Path towards the detour
	_pathing.set_target(detours.pick_random().global_position)
	_pathing.how_close = 1
	_pathing.start_logic(self)


func state_physics_process(_delta: float) -> void:
	if _pathing.is_setup:
		_pathing.process_logic()

		# If we're done pathing, attack the lighthouse
		if _pathing.is_complete:
			_pathing.stop_logic()
			_state_machine.transition_to("GoToLighthouse")
			return


func state_exit() -> void:
	_pathing.stop_logic()
