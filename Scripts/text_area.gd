extends Area2D

@export var text_key = ""
var active = false



func _process(delta):
	print(active)
	if active and Input.is_action_just_pressed("talk"):
		Bus.emit_signal("show_text", text_key)



func _on_area_entered(area):
	active = true


func _on_area_exited(area):
	active = false
