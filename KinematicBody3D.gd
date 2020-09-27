extends KinematicBody3D

@export
var velocity : float = rand_range(15, 25)

@export
var target_node_1 : NodePath = "../../Target"

func _ready():
	add_to_group("units")
	update_target()
	set_process(true)

func update_target():
	$NavigationAgent3D.set_target_location(get_node(target_node_1).get_global_transform().origin)

func _process(_delta):
	# Query the `NavigationAgent` to know the next free to reach location.
	var target = $NavigationAgent3D.get_next_location()
	var pos = get_global_transform().origin

	# Floor normal.
	var n = $RayCast3D.get_collision_normal()
	if n.length_squared() < 0.001:
		# Set normal to Y+ if on air.
		n = Vector3(0, 1, 0)

	# Calculate the velocity.
#	var vel = (target - pos).slide(n).normalized() * velocity
	var vel = (target - pos).normalized() * velocity
	move_and_slide(vel)
