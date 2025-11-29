extends CharacterBody2D
class_name Enemy

@export var player: Player
@export var speed:= 1.0
@export var damage = 5
@export var attackTime:=0.5
var attacking:=[]
var canAttack=true

const xp = preload("res://xp.tscn")

var dead=false

func _process(_delta: float) -> void:
	if(not dead):
		if(canAttack and len(attacking)>=1):
			canAttack=false
			for item in attacking:
				print("Badook")
				item.attack(damage)
			await get_tree().create_timer(attackTime).timeout
			canAttack=true

func _physics_process(_delta: float) -> void:
	if(not dead):
		velocity=player.global_position-global_position
		velocity*=speed
		move_and_slide()

func kill():
	dead=true
	$Icon.play("dead")
	


func _on_icon_animation_finished() -> void:
	var newXP=xp.instantiate()
	get_parent().add_child(newXP)
	newXP.global_position=global_position
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("AA")
	if(body.get_parent() is Player):
		print("AEWA")
		attacking.append(body.get_parent())


func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body.get_parent() is Player):
		attacking.erase(body.get_parent())
