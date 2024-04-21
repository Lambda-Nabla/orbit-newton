extends RigidBody2D

var speed = 5
var velocity := Vector2.ZERO
var rotation_direction = 0
var rotation_speed = 50
var health = 3
var playerGravity = 0

var root = get_tree().get_root().get_children()
var objects = root[0].get_children()
var planets = []

func get_nearest_body():
	var shortestDistance = Vector2(100000, 100000)
	for body in planets:
		var distance: Vector2 = body.position - self.position
		if distance < shortestDistance:
			shortestDistance = distance
	return shortestDistance
	
func _ready():
	for object in objects:
		if object is RigidBody2D:
			planets.append(object)

func calculate_gravity_force(target, bodies) -> Vector2:
	var sum := Vector2.ZERO
	for body in bodies:
		if (target != body):
			var distance: Vector2 = body.position - target.position
			sum += body.mass * (distance / (distance.length_squared() * distance.length())) * 10
	var gravity: Vector2 = target.mass * sum
	playerGravity = gravity 

	return gravity

func hurtPlayer(damage):
	health -= damage
	print("Hurt player for ", damage)

func checkDamage():
	if abs(velocity.x) > 25 or abs(velocity.y) > 25:
		hurtPlayer(3)
	elif abs(velocity.x) > 5 or abs(velocity.y) > 5:
		hurtPlayer(1)
	
func _physics_process(delta):
	rotation_direction = Input.get_axis("left", "right")
	
	if Input.get_axis("down", "up"):
		velocity += transform.x * Input.get_axis("down", "up") * speed * delta
	var rotation = rotation_direction * rotation_speed * delta
	set_angular_velocity(rotation)
	

	velocity += calculate_gravity_force(self, planets)

	var collision = move_and_collide(velocity)

	if(get_colliding_bodies()):
		checkDamage()
		velocity -= velocity


	print(velocity)
