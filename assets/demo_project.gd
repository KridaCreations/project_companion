extends Node2D

onready var project_view = $project_view
onready var list_container = $project_view/list_container
onready var demo_list = $list
onready var board = $board
onready var delete_option = $delete_option

var card_focused = false
var focused_card = false
var scene_location 
var child_focused = false
var focused_node = null



func _ready():
	delete_option.visible = false
	pass 


func _input(event):
	if event is InputEventMouseButton:
		if event.pressed == false:
			if card_focused == true:
				if delete_option.get_node("Sprite").frame == 1:
					focused_card.queue_free()
				delete_option.visible = false
				if focused_card != null:
					focused_card.follow = false
					focused_card.root.card_focused = false
					focused_card.last_position = focused_card.get_parent().get_child(focused_card.get_index()-1).get_global_position() + Vector2(0,focused_card.get_global_rect().size.y + focused_card.get_parent().get("custom_constants/separation"))			
					focused_card.set_global_position(focused_card.last_position)	
					focused_card.last_position = get_global_position()
					focused_card.offset = Vector2(0,0)
					focused_card = null
				card_focused = false


func _physics_process(delta):
	if child_focused == true:
		delete_option.visible = true
		var mouse_position = get_global_mouse_position()
		if project_view.get_global_rect().has_point(mouse_position) and (board.get_global_rect().has_point(mouse_position) == false):
			if mouse_position.x > board.get_global_rect().position.x + board.get_global_rect().size.x:
				project_view.scroll_horizontal +=2
			elif mouse_position.x < board.get_global_rect().position.x:
				project_view.scroll_horizontal -=2
			if mouse_position.y > board.get_global_rect().position.y + board.get_global_rect().size.y:
				project_view.scroll_vertical +=2
			elif mouse_position.y < board.get_global_rect().position.y:
				project_view.scroll_vertical -=2
		if delete_option.get_node("delete_button").get_global_rect().has_point(mouse_position):
			delete_option.get_node("Sprite").frame = 1
		else:
			delete_option.get_node("Sprite").frame = 0
			
		var c = list_container.get_children()
		for i in c:
			if i.get_global_rect().has_point(mouse_position) and i != focused_node :#and project_view.get_global_rect().encloses(i.get_global_rect()):	
				print(i.get_global_position())
				list_container.move_child(focused_node,i.get_index())
				focused_node.owner = self
				print(i.get_global_position())
				focused_node.last_position = i.get_global_position() #- Vector2(project_view.scroll_horizontal,project_view.scroll_vertical)

	
	elif card_focused == true:
		delete_option.visible = true
		var mouse_position = get_global_mouse_position()
		if project_view.get_global_rect().has_point(mouse_position) and (board.get_global_rect().has_point(mouse_position) == false):
			if mouse_position.x > board.get_global_rect().position.x + board.get_global_rect().size.x:
				project_view.scroll_horizontal +=2
			elif mouse_position.x < board.get_global_rect().position.x:
				project_view.scroll_horizontal -=2
			if mouse_position.y > board.get_global_rect().position.y + board.get_global_rect().size.y:
				project_view.scroll_vertical +=2
			elif mouse_position.y < board.get_global_rect().position.y:
				project_view.scroll_vertical -=2
		
		if delete_option.get_node("delete_button").get_global_rect().has_point(mouse_position):
			delete_option.get_node("Sprite").frame = 1
		else:
			delete_option.get_node("Sprite").frame = 0
		
		for i in list_container.get_children():
			if i.get_global_rect().has_point(mouse_position) and i != focused_card.get_parent() :#and project_view.get_global_rect().encloses(i.get_global_rect()):
				focused_card.get_parent().remove_child(focused_card)
				focused_card.last_position = i.get_child(i.get_child_count()-1).get_global_position()
				i.add_child_below_node(i.get_child(i.get_child_count()-2),focused_card)
				focused_card.owner = self
				if !focused_card.is_connected("gui_input",focused_card,"_on_card_gui_input"):
					focused_card.connect("gui_input",focused_card,"_on_card_gui_input")
				
				for j in i.get_children():
					if j.get_global_rect().has_point(mouse_position) and j != focused_card and j != i.get_node("new_card_name") and j != i.get_node("detail"):
						focused_card.last_position = j.get_global_position()
						i.move_child(focused_card,j.get_index())
						focused_card.owner = self
						
			elif i.get_global_rect().has_point(mouse_position) and i == focused_card.get_parent():# and project_view.get_global_rect().encloses(i.get_global_rect()):
				for j in i.get_children():
					if j.get_global_rect().has_point(mouse_position) and j != focused_card and j != i.get_node("new_card_name") and j != i.get_node("detail"):
						focused_card.last_position = j.get_global_position()
						i.move_child(focused_card,j.get_index())
						focused_card.owner = self

func _on_new_list_pressed():
	$Control.visible = true


func _on_LineEdit_text_entered(new_text):
	if $Control/LineEdit.text != "":
		$Control.visible = false
		var new_node = demo_list.duplicate(4)
		list_container.add_child(new_node)
		new_node.set_owner(self)
		new_node.root = self
		new_node.get_node("detail").text = new_text
		if !new_node.get_node("new_card_name").is_connected("text_entered",new_node,"_on_new_card_name_text_entered"):
			new_node.get_node("new_card_name").connect("text_entered",new_node,"_on_new_card_name_text_entered")
		if !new_node.get_node("detail").is_connected("gui_input",new_node,"_on_detail_gui_input"):
			new_node.get_node("detail").connect("gui_input",new_node,"_on_detail_gui_input")
		for i in new_node.get_children():
			i.set_owner(self)
		new_node.demo_card = $card
		$Control/LineEdit.text = ""

func _on_cancel_pressed():
	$Control/LineEdit.text = ""
	$Control.visible = false


func _on_done_pressed():
	if $Control/LineEdit.text != "":
		$Control.visible = false
		var new_node = demo_list.duplicate(4)
		list_container.add_child(new_node)
		new_node.set_owner(self)
		new_node.root = self
		new_node.get_node("detail").text = $Control/LineEdit.text
		if !new_node.get_node("new_card_name").is_connected("text_entered",new_node,"_on_new_card_name_text_entered"):
			new_node.get_node("new_card_name").connect("text_entered",new_node,"_on_new_card_name_text_entered")
		if !new_node.get_node("detail").is_connected("gui_input",new_node,"_on_detail_gui_input"):
			new_node.get_node("detail").connect("gui_input",new_node,"_on_detail_gui_input")
		for i in new_node.get_children():
			i.set_owner(self)
		new_node.demo_card = $card
		$Control/LineEdit.text = ""


func _on_back_pressed():
	var c = PackedScene.new()
	c.pack(get_tree().get_current_scene())
	ResourceSaver.save("c://godot_repository/" + $debug_label.text +".tscn",c)
	get_tree().change_scene("res://scences/main_screen.tscn")
