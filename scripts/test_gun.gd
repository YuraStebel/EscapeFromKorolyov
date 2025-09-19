extends RigidBody3D

@onready var gun_ray_cast = $GunRayCast

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("attack1"):
		var get_collision = gun_ray_cast.get_collider()
		print(get_collision)
		if get_collision and get_collision.is_in_group("enemy"):
			print('hit')
