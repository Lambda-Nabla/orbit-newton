extends RigidBody2D

var minigameServer

var speed = 5
var velocity := Vector2.ZERO
var rotation_direction = 0
var rotation_speed = 75
var health = 3
var playerGravity = 0

var redSpeed = 15
var orangeSpeed = 5

var root
var objects
var planets = []

func get_nearest_body():
	var shortestDistance = 100000.0
	for body in planets:
		var distance: float = self.position.distance_to(body.position)
		if distance < shortestDistance:
			shortestDistance = distance
			
	return shortestDistance
	
func _ready():
	root  = get_tree().get_root().get_children()
	objects = root[1].get_children()
	for object in objects:
		if object is RigidBody2D and object != self:
			planets.append(object)
	
	minigameServer = get_node("/root/MinigameServer")

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
	if abs(velocity.x) > redSpeed or abs(velocity.y) > redSpeed:
		hurtPlayer(3)
	elif abs(velocity.x) > orangeSpeed or abs(velocity.y) > orangeSpeed:
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
		if velocity.length() > 0:
			minigameServer.serve_minigame()
		velocity -= velocity
