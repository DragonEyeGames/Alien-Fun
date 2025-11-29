extends CharacterBody2D
class_name Player
var xp=0
@export var speed:=100.0

@export var waitTime:=1.0

@export var health=100
var sprite

func _ready() -> void:
	sprite=$Sprite2D

func _physics_process(_delta: float) -> void:
	var currentSpeed=WeaponManager.items["player"]["stats"]["speed"]*speed
	velocity=Input.get_vector("Left", "Right", "Up", "Down")
	velocity*=currentSpeed
	move_and_slide()
	if(abs(velocity.x)<=.05):
		velocity.x=0
	if(abs(velocity.y)<=0.5):
		velocity.y=0
	if(velocity==Vector2.ZERO):
		if(not sprite.animation=="idle"):
			sprite.play("idle")
	elif(velocity.x<0 and abs(velocity.x)>=abs(velocity.y)):
		if(not sprite.animation=="walkLeft"):
			sprite.play("walkLeft")
	elif(velocity.x>0 and abs(velocity.x)>=abs(velocity.y)):
		if(not sprite.animation=="walkRight"):
			sprite.play("walkRight")
	elif(velocity.y<0 and abs(velocity.y)>=abs(velocity.x)):
		if(not sprite.animation=="walkUp"):
			sprite.play("walkUp")
	elif(velocity.y>0 and abs(velocity.y)>=abs(velocity.x)):
		if(not sprite.animation=="walk"):
			sprite.play("walk")
	
func attack(damage):
	damage*=2
	health-=damage
	if(health<=0):
		visible=false
		get_tree().paused=true
