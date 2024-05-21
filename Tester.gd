extends Node

@export var sim_input: SimulatedInput
@export var nav: NavigationAgent3D
@export var target: Node3D

var move_axis := InputAxis2d.new(
	InputAxis1d.new("player_move_left", "player_move_right"),
	InputAxis1d.new("player_move_forward", "player_move_back")
)

var look_axis: InputAxis2d = InputAxis2d.new(
	InputAxis1d.new("player_look_left", "player_look_right"),
	InputAxis1d.new("player_look_down", "player_look_up")
)


func _physics_process(_delta):
	nav.set_target_position(target.global_position)


func _on_timer_timeout():
	print("Trying jump")
	nav.set_target_position(target.global_position)
	# sim_input.simulate_action_oneshot("player_jump")


func _process(_delta):
	if not nav.is_navigation_finished():
		var movement_dir: Vector3 = get_parent().global_position.direction_to(
			nav.get_next_path_position()
		)
		sim_input.simulate_axis_2d(
			move_axis, Vector2(movement_dir.x, movement_dir.z)
		)

	# sim_input.simulate_axis_2d(move_axis, Vector2.UP)

	# var look_dir = Vector2.LEFT * _delta * 1000
	# sim_input.simulate_axis_2d(look_axis, look_dir)
