extends Control

var username = ''
var password = ''
var storedUsername = ''
var storedPassword = ''
@onready var message = $RichTextLabel
var created = false


func _ready():
	message.visible = false

func _on_button_pressed():
	username = $Username.text
	password = $Password.text
	if not created and username != '' and password != '':
		created = true
		$Button.text = "Login"
		storedUsername = username
		storedPassword  = password
	elif created:
		if username == storedUsername and password == storedPassword:
			print("correct login")
			get_tree().change_scene_to_file("res://main_menu.tscn")
		else:
			message.visible = true
			$Timer.start() 
	print(username,'',password)
	message.visible = true
	$Timer.start()

func _on_timer_timeout():
	message.visible = false 
