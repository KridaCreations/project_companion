extends Node2D

onready var list_container = $project_view/list_container
onready var demo_list = $list

var child_foccused = false

func _ready():
	pass 


func _physics_process(delta):
	$debug_label.text = str($project_view/list_container.get_global_position())


func _on_new_list_pressed():
	$Control.visible = true
#	var new_node = demo_list.duplicate(4)
#	list_container.add_child(new_node)
#	new_node.get_node("new_card_name").connect("text_entered",new_node,"_on_new_card_name_text_entered")
#	new_node.demo_card = $card


func _on_LineEdit_text_entered(new_text):
	if $Control/LineEdit.text != "":
		$Control/LineEdit.text = ""
		$Control.visible = false
		var new_node = demo_list.duplicate(4)
		list_container.add_child(new_node)
		new_node.set_owner(list_container)
		#print(new_node.owner.name)
		#new_node.set_owner(list_container)
		new_node.root = self
		new_node.get_node("detail").text = new_text
		new_node.get_node("new_card_name").connect("text_entered",new_node,"_on_new_card_name_text_entered")
		new_node.get_node("detail").connect("gui_input",new_node,"_on_detail_gui_input")
#		print(new_node.get_node("detail").connect("mouse_entered",new_node,"_on_detail_mouse_entered"))
#		print(new_node.get_node("detail").connect("mouse_entered",new_node,"_on_list_mouse_entered"))
		new_node.demo_card = $card


func _on_cancel_pressed():
	$Control/LineEdit.text = ""
	$Control.visible = false


func _on_done_pressed():
	#= ""
	if $Control/LineEdit.text != "":
		$Control.visible = false
		var new_node = demo_list.duplicate(4)
		list_container.add_child(new_node)
		#new_node.set_owner(list_container)
		new_node.root_name = name
		new_node.get_node("detail").text = $Control/LineEdit.text
		new_node.get_node("new_card_name").connect("text_entered",new_node,"_on_new_card_name_text_entered")
		(new_node.get_node("detail").connect("gui_input",new_node,"_on_detail_gui_input"))
		new_node.demo_card = $card
		$Control/LineEdit.text = ""
