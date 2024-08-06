extends Node3D

@export var woodbot_npc_scene: PackedScene = null
@export var bots_to_spawn: int = 10
@export var spawn_extents: float = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(0.5).timeout

	for x in range(bots_to_spawn):
		_spawn_bot()


func _spawn_bot() -> void:
	# Determine where to spawn the bot
	var spawn_position: Vector3 = $SpawnZone.global_position
	spawn_position.x += randf_range(-spawn_extents, spawn_extents)
	spawn_position.z += randf_range(-spawn_extents, spawn_extents)

	# Create the bot and move it to the spawn location
	var bot: NPCAgent3D = woodbot_npc_scene.instantiate()
	add_child(bot)
	bot.global_position = spawn_position
