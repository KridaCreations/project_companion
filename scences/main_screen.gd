extends Control

export (PackedScene) var demo_project
export (String) var projects_folder 

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
	if dir.open(projects_folder) == OK:
		dir.list_dir_begin(true)
		var file_name = dir.get_next()
		#print(file_name + "here")
		while file_name != "":
			if dir.current_is_dir():
				pass#print("Found directory: " + file_name)
			else:
				#print("Found file: " + file_name)
				var new_button = scene_button.duplicate(4)
				
				var c = file_name
				c.erase(c.length()-5,5)
				new_button.name = c
				new_button.associated_scene = projects_folder + file_name
				list_of_scenes.add_child(new_button)
				new_button.text = c
				new_button.connect("pressed",new_button,"open_scene")
				
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
		
		
func save(string):
	pass
	
func _ready():
	#print("here")
	load_list()
	$Control.visible = false
	


func _process(delta):
	pass


func _on_start_project_pressed():
	$Control.visible = true
	
#func save(content):
#    var file = File.new()
#    file.open("user://save_game.dat", File.WRITE)
#    file.store_string(content)
#    file.close()
#
#func load():
#    var file = File.new()
#    file.open("user://save_game.dat", File.READ)
#    var content = file.get_as_text()
#    file.close()
#    return content




func _on_LineEdit_text_entered(new_text):
	if new_text != "":
		var new_scene  = demo_project.instance()
		new_scene.get_node("debug_label").text = new_text
		#new_scene.scene_location = "res://projects/" + new_text +".tscn" 
		demo_project.pack(new_scene)
		ResourceSaver.save("res://projects/" + new_text +".tscn",demo_project)
		get_tree().change_scene("res://projects/" + new_text +".tscn")
		$Control.visible = false
#		var file = File.new()
#		file.open("res://save_data/save_game.dat", File.WRITE)
#		file.store_string("res://projects/" + new_text +".tscn")
#		file.close()


func _on_cancel_pressed():
	$Control.visible = false


func _on_done_pressed():
	if $Control/LineEdit.text != "":
		var new_scene  = demo_project.instance()
		new_scene.get_node("debug_label").text = $Control/LineEdit.text
		#new_scene.scene_location = "res://projects/" + $Control/LineEdit.text +".tscn" 
		demo_project.pack(new_scene)
		
		ResourceSaver.save("res://projects/" + $Control/LineEdit.text +".tscn",demo_project)
		get_tree().change_scene("res://projects/" + $Control/LineEdit.text +".tscn")
		$Control.visible = false

