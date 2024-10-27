extends CanvasLayer

@export_file("*.json") var text_file: String 

var scene_text = {}
var selected_text = []
var in_progress = false

@onready var background = $Background
@onready var text_lable = $TextLabel

func _ready():
	scene_text = load_scene_text()
	print(scene_text)
	Bus.show_text.connect(on_display_dialogue)

func load_scene_text():
	var file = FileAccess.open(text_file, FileAccess.READ)
	if file:  
		var json = JSON.new()
		var content = file.get_as_text()
		file.close()  
		#var result = json.parse(content) 
		var result = JSON.parse_string(content) 
		return result
		
	else:
		print("Failed to open the file or no file selected.")
		return null 
		
		
func next_line():
	if selected_text.size() > 0:
		show_text()
	else:
		finish()
	
func show_text():
	text_lable.text = selected_text.pop_front()	
	
func finish():
	text_lable.text = ""
	background.visible = false
	in_progress = false
	get_tree().paused = false
		
func on_display_dialogue(text_key):
	if in_progress:
		next_line() 
	else:
		get_tree().paused = true
		background.visible = true
		in_progress = true
		selected_text = scene_text[text_key].duplicate()
		show_text()
