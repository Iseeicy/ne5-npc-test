extends Node

@export var sim_input: SimulatedInput


func _on_timer_timeout():
	print("Trying jump")
	sim_input.simulate_action_oneshot("player_jump")
