extends Control

var username = ''
var password = ''
@onready var message = $RichTextLabel


func _ready():
	message.visible = false

func _on_button_pressed():
	username = $Username.text
	password = $Password.text
	print(username,'',password)
	message.visible = true
	$Timer.start()

func _on_timer_timeout():
	print('siefh')
	message.visible = false 
	var username = $Username
	var password = $Password
