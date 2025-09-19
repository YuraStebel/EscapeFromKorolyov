extends Node

var health_current: float
var health_max: float = 100

@onready var health_bar = $"../HUD/HBoxContainer/HPBar"
@onready var vignette = $"../HUD/VignetteContainer"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_current = health_max
	

func dying():
	get_parent().is_alive = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if health_current >= 100:
		health_bar.visible = false
	else: 
		health_bar.visible = true
	
	health_current = max(health_current, 0)
	
	health_bar.value = health_current
	
	vignette.modulate = Color(1,1,1, 1 - health_current / 50)
	
	if health_current <= 0:
		dying()
	
