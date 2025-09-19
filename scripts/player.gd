extends CharacterBody3D

@onready var cam_holder: Node3D = $CameraHolder
@onready var interact_cast: RayCast3D = $CameraHolder/Camera3D/InteractCast

@onready var hand: Node3D = $CameraHolder/Camera3D/Hand
var is_item_in_hands: bool = false

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var mouse_sens: float = 0.004


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x * mouse_sens
		cam_holder.rotation.x -= event.relative.y * mouse_sens
		cam_holder.rotation.x = clamp(cam_holder.rotation.x, -PI/2, PI/2)
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func use():
	if Input.is_action_just_pressed('use'):
		var get_collision = interact_cast.get_collider()
		print(get_collision)
		if get_collision and get_collision.is_in_group('pickable') and not is_item_in_hands:
			get_collision.reparent(hand)
			get_collision.freeze = true
			get_collision.position = Vector3.ZERO
			get_collision.rotation = Vector3.ZERO

func drop():
	if Input.is_action_just_pressed('drop'):
		if hand.get_child_count() > 0:
			var item_in_hands = hand.get_child(0)
			item_in_hands.reparent(get_tree().current_scene)
			if item_in_hands is RigidBody3D:
				item_in_hands.freeze = false
			is_item_in_hands = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	use()
	drop()
	
	move_and_slide()
