extends NPCState

var _pathing := NPCPathingLogic.new()


func state_enter(_message: Dictionary = {}) -> void:
	# If we don't know about the lighthouse, EXIT EARLY
	var lighthouse := WoodbotUtils.find_lighthouse(get_tree())
	if lighthouse == null:
		_state_machine.transition_to("None")
		return

	# Path towards the lighthouse
	_pathing.set_target(lighthouse.global_position)
	_pathing.how_close = 5
	_pathing.start_logic(self)


func state_physics_process(_delta: float) -> void:
	if _pathing.is_setup:
		_pathing.process_logic()

		# If we're done pathing, attack the lighthouse
		if _pathing.is_complete:
			_pathing.stop_logic()
			_state_machine.transition_to("AttackLighthouse")
			return


func state_exit() -> void:
	_pathing.stop_logic()
