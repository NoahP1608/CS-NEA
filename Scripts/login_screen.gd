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


func _on_timer_timeout():
	message.visible = false
