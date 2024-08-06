class_name WoodbotUtils
extends RefCounted

const LIGHTHOUSE_GROUP = "lighthouse_poi"
const DETOUR_GROUP = "bot_detour"


static func find_lighthouse(scene_tree: SceneTree) -> Node3D:
	return scene_tree.get_first_node_in_group(LIGHTHOUSE_GROUP)


static func find_detours(scene_tree: SceneTree) -> Array[Node]:
	return scene_tree.get_nodes_in_group(DETOUR_GROUP)
