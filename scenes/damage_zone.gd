extends Area3D

var is_player_in_zone: bool = false
var player: CharacterBody3D = null
var damage_by_zone = 10  # урон за физический тик (примерно 60 раз в секунду)

func _physics_process(delta: float) -> void:
	if is_player_in_zone and player is CharacterBody3D:
		var stats_node = player.get_node_or_null("PlayerStats")
		if stats_node and "health_current" in stats_node:
			stats_node.health_current -= damage_by_zone * delta
			stats_node.health_current = max(stats_node.health_current, 0)

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group('player') and body is CharacterBody3D:
		is_player_in_zone = true
		player = body

func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group('player') and body == player:
		is_player_in_zone = false
		player = null
