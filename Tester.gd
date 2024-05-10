extends Node

@export var sim_input: SimulatedInput

var move_axis := InputAxis2d.new(
	InputAxis1d.new("player_move_left", "player_move_right"),
	InputAxis1d.new("player_move_forward", "player_move_back")
)

var look_axis: InputAxis2d = InputAxis2d.new(
	InputAxis1d.new("player_look_left", "player_look_right"),
	InputAxis1d.new("player_look_down", "player_look_up")
)


func _on_timer_timeout():
	print("Trying jump")
	sim_input.simulate_action_oneshot("player_jump")


func _process(_delta):
	sim_input.simulate_axis_2d(move_axis, Vector2.UP)

	var look_dir = Vector2.LEFT * _delta * 1000
	sim_input.simulate_axis_2d(look_axis, look_dir)
