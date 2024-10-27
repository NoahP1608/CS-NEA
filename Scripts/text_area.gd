extends Area2D

@export var text_key = ""
var active = false


func _process(delta):
	print(active)


func _input(event):
	if active and event.is_action_pressed("talk"):
		Bus.emit_signal("show_text", text_key)


func _on_area_entered(area):
	active = true


func _on_area_exited(area):
	active = false
