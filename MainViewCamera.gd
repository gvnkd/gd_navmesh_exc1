extends Camera3D

var ray_length = 1000

@export
var target_node_1 : NodePath = "../Target"

@export
var actor_1 : NodePath = "../Navigation3D/KinematicBody3D"

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		print("clicked")
		var from = project_ray_origin(event.position)
		print(from)
		var to = from + project_ray_normal(event.position) * ray_length
		print(to)
		var space_state = get_world_3d().direct_space_state
		var result = space_state.intersect_ray(from, to, [], 1)
		print(result)
		if result:
			print("move target")
			get_node(target_node_1).global_transform.origin = result.position
			get_tree().call_group("units", "update_target")
#			get_node(actor_1).update_target()
# Called when the node enters the scene tree for the first time.

func _ready():
	set_process_input(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
