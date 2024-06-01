extends Node

@export var sim_input: SimulatedInput
@export var nav: NavigationAgent3D
@export var target: Node3D


func _physics_process(_delta):
	nav.set_target_position(target.global_position)


func _on_timer_timeout():
	print("Updating pos")
	nav.set_target_position(target.global_position)


func _process(_delta):
	if not nav.is_navigation_finished():
		var movement_dir: Vector3 = get_parent().global_position.direction_to(
			nav.get_next_path_position()
		)
		sim_input.simulate_axis_2d(
			BobboInputs.Player.Move.axis,
			Vector2(movement_dir.x, movement_dir.z)
		)
