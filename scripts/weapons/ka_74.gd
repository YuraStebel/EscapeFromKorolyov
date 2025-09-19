extends RigidBody3D
class_name ak

var is_in_hand: bool = false

@onready var anim_player: AnimationPlayer = $AnimationPlayer


func _physics_process(delta: float) -> void:
	if is_in_hand:
		anim_player.play("AK_HoldPose")
		get_parent().get_node("PlayerModel").anim_player.play("Player_Hold-AK")
	else:
		anim_player.play("AK_T-Pose")
