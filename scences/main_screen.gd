extends Control

export (PackedScene) var demo_project
export (String) var projects_folder 

onready var delete_button = $delete_option
onready var list_of_scenes = $ScrollContainer/VBoxContainer
onready var scene_button = $scene_opener


 
#func dir_contents(path):
#    var dir = Directory.new()
#    if dir.open(path) == OK:
#        dir.list_dir_begin()
#        var file_name = dir.get_next()
#        while file_name != "":
#            if dir.current_is_dir():
#                print("Found directory: " + file_name)
#            else:
#                print("Found file: " + file_name)
#            file_name = dir.get_next()
#    else:
#        print("An error occurred when trying to access the path.")



func load_list():
	var dir = Directory.new()
	if !dir.dir_exists(projects_folder):
		dir.make_dir_recursive(projects_folder)
	if dir.open(projects_folder) == OK:
		dir.list_dir_begin(true,true)
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				pass
			elif  file_name.ends_with(".tscn"):
				var new_button = scene_button.duplicate(4)
				var c = file_name
				c.erase(c.length()-5,5)
				new_button.root = self
				new_button.name = c
				new_button.associated_scene = projects_folder + file_name
				list_of_scenes.add_child(new_button)
				new_button.text = c
				if !new_button.is_connected("button_up",new_button,"open_scene"):
					new_button.connect("button_up",new_button,"open_scene")
				if !new_button.is_connected("gui_input",new_button,"gui_input"):
					new_button.connect("gui_input",new_button,"gui_input")
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
		
		
func save(string):
	pass
	
func _ready():
	$delete_option.visible = false
	load_list()
	$Control.visible = false
	


func _process(delta):
	pass


func _on_start_project_pressed():
	$Control.visible = true
	



func _on_LineEdit_text_entered(new_text):
	if new_text != "":
		var new_scene  = demo_project.instance()
		new_scene.get_node("debug_label").text = new_text 
		demo_project.pack(new_scene)
		ResourceSaver.save("user://" + new_text +".tscn",demo_project)
		get_tree().change_scene("user://" + new_text +".tscn")
		$Control.visible = false


func _on_cancel_pressed():
	$Control.visible = false


func _on_done_pressed():
	if $Control/LineEdit.text != "":
		var new_scene  = demo_project.instance()
		new_scene.get_node("debug_label").text = $Control/LineEdit.text
		demo_project.pack(new_scene)
		ResourceSaver.save(projects_folder + $Control/LineEdit.text +".tscn",demo_project)
		get_tree().change_scene(projects_folder + $Control/LineEdit.text +".tscn")
		$Control.visible = false

