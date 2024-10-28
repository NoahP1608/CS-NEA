extends CharacterBody2D


const WALKSPEED = 100

var enemy_in_attack_range = false
var enemy_attack_cooldown = true
var health = 100
var isAlive = true


func _physics_process(delta):
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if direction:
		if direction.x < 0:
			$sprite.flip_h = true #flip the horizaontal position if the x dirction is less than 0
		elif direction.x > 0:
			$sprite.flip_h = false
		$AnimationPlayer.play('run') #if the direction is not 0 than play the run animation
	elif Input.is_action_pressed("attack"):
		$AnimationPlayer.play("attack")
	else:
		if GlobalControl.can_attack:
			$AnimationPlayer.play('attack') #if not moving and the attack state is active than play the attack
		else:
			$AnimationPlayer.play('idle') #else play the idle animation
	velocity = direction*WALKSPEED*delta
	move_and_slide()
	if health <= 0:
		print('Player dead')
		self.queue_free()
		
	
	if Input.is_action_just_pressed("attack"): #if the space key is pressed, play the animation
		$attacktimer.start() #animation player
		GlobalControl.can_attack = true #allows the animation to play
	enemy_attack()
	updateHealth()
	#print(GlobalControl.can_attack)

func _on_attacktimer_timeout():
	GlobalControl.can_attack = false #stops the animation after 1 second

func _on_attackcooldown_timeout():
	enemy_attack_cooldown = true #timer has gone off so the enemy can now attack again

func _on_playerhitbox_body_entered(body):
	if body.name == "enemy":
		enemy_in_attack_range = true #if the enemy collides with the player they can attack
	
func _on_playerhitbox_body_exited(body):
	if body.name == "enemy":
		enemy_in_attack_range = false
		
func enemy_attack():
	if enemy_in_attack_range and enemy_attack_cooldown == true: #enemy can only attack when the player is touching it
		health -= 20 #Subtract health from the player
		enemy_attack_cooldown = false
		$attackcooldown.start()

func player():
	pass
	
func updateHealth():
	var HealthBar = $HealthBar
	HealthBar.value = health
