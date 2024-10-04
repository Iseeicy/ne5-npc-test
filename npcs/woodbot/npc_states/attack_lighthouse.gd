extends NPCState

const ATTACK_INTERVAL: int = 3
var _timeout: float = 0


func state_enter(_message: Dictionary = {}) -> void:
	# Display the attack animation and reset the timer
	agent_3d.playermodel.fire_oneshot("parameters/attack_1/request")
	_timeout = ATTACK_INTERVAL


func state_physics_process(delta: float) -> void:
	_timeout -= delta

	# If we have finished attacking, try to go to the lighthouse again.
	# If we're already at the lighthouse, then within a frame or so we
	# should attack once more - effectively making this state loop.
	if _timeout <= 0:
		_state_machine.transition_to("GoToLighthouse")
		return
