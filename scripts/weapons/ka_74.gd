extends Weapon
class_name ak

@onready var anim_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	fire_rate = 600
	damage = 40
	ammo_max = 30
	ammo_current = ammo_max

func _physics_process(delta: float) -> void:
	if is_in_hand:
		anim_player.play("AK_HoldPose")
		get_parent().get_node("PlayerModel").anim_player.play("Player_Hold-AK")
	else:
		anim_player.play("AK_T-Pose")
	shoot(delta)
	reload()
