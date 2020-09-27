extends RigidBody3D


@export
var velocity : float = 10
	
@export
var target_node_1 : NodePath = "../../Target"

func _ready():
	$NavigationAgent3D.set_target_location(get_node(target_node_1).get_global_transform().origin)

func _physics_process(_delta):
	# Query the `NavigationAgent` to know the next free to reach location.
	var target = $NavigationAgent3D.get_next_location()
	var pos = get_global_transform().origin

	# Floor normal.
	var n = $RayCast3D.get_collision_normal()
	if n.length_squared() < 0.001:
		# Set normal to Y+ if on air.
		n = Vector3(0, 1, 0)

	# Calculate the velocity.
	var vel = (target - pos).slide(n).normalized() * velocity
	set_linear_velocity(vel)
