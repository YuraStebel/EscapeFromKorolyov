extends Weapon
class_name ak

@onready var anim_player: AnimationPlayer = $AnimationPlayer

@onready var KA74_shooting_audio = preload("res://sounds/weapon/KA74/KA74_shoot.ogg")
@onready var KA74_no_ammo_audio = preload("res://sounds/weapon/KA74/KA74_no_ammo.ogg")

func _ready() -> void:
	fire_rate = 600
	damage = 40
	ammo_max = 30
	ammo_current = ammo_max

func _physics_process(_delta: float) -> void:
	if is_in_hand:
		anim_player.play("AK_HoldPose")
		get_parent().get_node("PlayerModel").anim_player.play("Player_Hold-AK")
	else:
		anim_player.play("AK_T-Pose")
	if ammo_current > 0 and shooting_audio.stream != KA74_shooting_audio: 
		shooting_audio.stream = KA74_shooting_audio
	elif ammo_current <= 0 and shooting_audio.stream != KA74_no_ammo_audio and shooting_audio.playing == false:
		shooting_audio.stream = KA74_no_ammo_audio
	shoot()
	reload()
