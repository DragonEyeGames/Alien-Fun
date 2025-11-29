extends CharacterBody2D
class_name Player
var xp=0
@export var speed:=100.0

@export var waitTime:=1.0

@export var health=100

func _physics_process(_delta: float) -> void:
	var currentSpeed=WeaponManager.items["player"]["stats"]["speed"]*speed
	velocity=Input.get_vector("Left", "Right", "Up", "Down")
	velocity*=currentSpeed
	move_and_slide()
	
func attack(damage):
	health-=damage
	if(health<=0):
		visible=false
		get_tree().paused=true
