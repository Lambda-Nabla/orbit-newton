extends RigidBody2D

var speed = 5
var velocity := Vector2.ZERO
var rotation_direction = 0
var rotation_speed = 50

func calculate_gravity_force(target, bodies) -> Vector2:
	var sum := Vector2.ZERO
	for body in bodies:
		if (target != body):
			var distance: Vector2 = body.position - target.position
			sum += body.mass * (distance / (distance.length_squared() * distance.length())) * 10
			print("Distance: ", distance.length())
	var gravity: Vector2 = target.mass * sum

	print("Gravity: ", gravity)
	return gravity

func _physics_process(delta):
	rotation_direction = Input.get_axis("left", "right")
	
	if Input.get_axis("down", "up"):
		velocity += transform.x * Input.get_axis("down", "up") * speed * delta
	var rotation = rotation_direction * rotation_speed * delta
	set_angular_velocity(rotation)
	
	print("Direction", rotation_direction)
	
	print("Colliding: ", get_tree().get_root().get_children())
	var root = get_tree().get_root().get_children()
	velocity += calculate_gravity_force(self, root[0].get_children())

	var collision = move_and_collide(velocity)

	print(velocity)
