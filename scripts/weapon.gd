extends RigidBody3D
class_name Weapon

@onready var gun_ray_cast = $GunRayCast
@onready var shooting_audio = $ShootsAudioPlayer

var is_in_hand: bool = false

var damage: float
var ammo_max: int
var ammo_current: int

var fire_rate: float #ВЫСТРЕЛОВ В МИНУТУ
var can_shoot: bool = true
var shoot_timer: float = 0.0
var last_shot_time: float = 0.0

func shoot():
	var current_time = Time.get_ticks_msec() / 1000.0
	var fire_delay = 60.0 / fire_rate
	
	if is_in_hand and Input.is_action_pressed("attack1") and ammo_current > 0:
		if current_time - last_shot_time >= fire_delay:
			shooting_audio.play()
			var get_collision = gun_ray_cast.get_collider()
			
			if get_collision and get_collision.is_in_group("enemy"):
				print('hit')
			
			ammo_current -= 1
			last_shot_time = current_time
			print("Ammo: ", ammo_current, "/", ammo_max)
	elif Input.is_action_just_pressed("attack1") and ammo_current == 0:
		shooting_audio.play()
		print("NO AMMO")

func reload():
	if Input.is_action_just_pressed("reload") and is_in_hand:
		ammo_current = ammo_max
		print("RELOADED...")
