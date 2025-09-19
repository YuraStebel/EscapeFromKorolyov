extends Node

var health_current: float
var health_max: float = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_current = health_max

func dying():
	get_parent().is_alive = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	health_current = max(health_current, 0)
	
	if health_current <= 0:
		dying()
	print(health_current)
	
