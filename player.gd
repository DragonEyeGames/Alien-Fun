extends CharacterBody2D
class_name Player
var xp=0
@export var speed:=100.0

@export var waitTime:=1.0

@export var health=20

func _physics_process(_delta: float) -> void:
	velocity=Input.get_vector("Left", "Right", "Up", "Down")
	velocity*=speed
	move_and_slide()
	
func attack(damage):
	health-=damage
	visible=false
	get_tree().paused=true
