extends CharacterBody2D
class_name Enemy

@export var player: Player
@export var speed:= 1.0
@export var damage = 5
@export var attackTime:=0.5
@export var health = 2
var attacking:=[]
var canAttack=true
@export var boss:=false
@export var shooter:=false
@export var type=""
@export var projectile: PackedScene
var shooting:=[]
var canShoot=true
var hud

var maxHealth=0

const xp = preload("res://Scenes/xp.tscn")

var dead=false

func _ready():
	await get_tree().process_frame
	if(boss):
		$Health.visible=true
		$Health.max_value=health
		$Health.value=health
	else:
		maxHealth=health

func _process(_delta: float) -> void:
	if(boss):
		$Health.value=health
	if(WeaponManager.double and not boss):
		return
	if(not dead):
		if(canAttack and len(attacking)>=1):
			canAttack=false
			for item in attacking:
				item.attack(damage)
			await get_tree().create_timer(attackTime).timeout
			canAttack=true
		if(shooter and canShoot and len(shooting)>=1):
			canShoot=false
			for item in shooting:
				$Icon.play("shoot")
				await get_tree().create_timer(.2).timeout
				var newProjectile=projectile.instantiate()
				get_parent().add_child(newProjectile)
				newProjectile.global_position=self.global_position
				newProjectile.type=type
				newProjectile.damage=damage
				newProjectile.target=player
			await get_tree().create_timer(attackTime*2).timeout
			canShoot=true

func _physics_process(_delta: float) -> void:
	if(WeaponManager.double and not boss):
		return
	if(not dead):
		velocity=player.global_position-global_position
		velocity*=speed
		if(velocity.x<0):
			$Icon.flip_h=true
		else:
			$Icon.flip_h=false
		move_and_slide()

func hurt(newDamage):
	$Flash.play("hit")
	$Hit.pitch_scale=1+randf_range(-.1, .1)
	$Hit.play()
	health-=newDamage
	var counter = load("res://Scenes/damageCount.tscn").instantiate()
	get_parent().add_child(counter)
	counter.global_position=global_position
	counter.damage=newDamage
	if(health<=0):
		die()

func die():
	dead=true
	WeaponManager.score+=maxHealth
	WeaponManager.killCount+=1
	$Splat.pitch_scale+=randf_range(-.1, .1)
	$Splat.play()
	$Icon.play("dead")
	


func _on_icon_animation_finished() -> void:
	if($Icon.animation=="dead"):
		if(boss==false):
			var newXP=xp.instantiate()
			get_parent().add_child(newXP)
			newXP.global_position=global_position
		else:
			hud.bossDefeated()
		queue_free()
	else:
		$Icon.play("walkSide")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.get_parent() is Player):
		attacking.append(body.get_parent())


func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body.get_parent() is Player):
		attacking.erase(body.get_parent())


func _on_shoot_zone_body_entered(body: Node2D) -> void:
	if(body.get_parent() is Player):
		shooting.append(body.get_parent())


func _on_shoot_zone_area_exited(area: Area2D) -> void:
	if(area.get_parent() is Player and area.get_parent() in shooting):
		shooting.erase(area.get_parent())
