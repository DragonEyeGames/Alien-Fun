extends CharacterBody2D
class_name Player

@export var speed:=100.0

@export var waitTime:=1.0

func _physics_process(_delta: float) -> void:
	velocity=Input.get_vector("Left", "Right", "Up", "Down")
	velocity*=speed
	move_and_slide()
