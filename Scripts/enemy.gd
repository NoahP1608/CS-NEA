extends CharacterBody2D

var speed = 40
var player_chase = false
var player_touching = false
var player = null
var enemyHealth = 100
var dead = false

#331 

func _ready():
	player = get_node("player.tscn")

func _physics_process(delta):
	if dead:
		return
	var direction = get_direction()
	var distance_to_player = get_distance()
	if player_chase and not player_touching and not dead: #only chase the player if they are in the radius but not touching them
		velocity = direction*speed
		move_and_slide()
		$AnimatedSprite2D.play('walk')
		if (player.position.x-position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play('idle')
	damage()
	updateHealth()
	

func _on_detection_radius_body_entered(body):
	if body.name == 'Player': #if the player enetres the radius
		player = body
		player_chase = true

func _on_detection_radius_body_exited(body):
	if body.name == 'Player': #if the player exits the radius
		player = null
		player_chase = false

func _on_main_collision_area_body_entered(body):
	if body.name == 'Player':
		player_touching = true #changes the state for if the enemy if touching the player

func _on_main_collision_area_body_exited(body):
	if body.name == 'Player':
		player_touching = false
		
func enemy():
	pass

func damage():
	if player_touching and GlobalControl.can_attack == true:
		enemyHealth -= 1
	if enemyHealth <= 0:
		dead = true
		$AnimatedSprite2D.play("death")
		$deathTimer.start()
		
		
func updateHealth():
	var HealthBar = $HealthBar
	HealthBar.value = enemyHealth

func get_direction():
	if player == null:
		return 
	else:
		return (player.position - position).normalized()
		
func get_distance():
	if player == null:
		return 
	else:
		return position.distance_to(player.position)


func _on_death_timer_timeout():
	queue_free()
