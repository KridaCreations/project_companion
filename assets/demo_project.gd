extends Node2D

onready var list_container = $project_view/list_container
onready var demo_list = $list


func _ready():
	pass 




func _on_new_list_pressed():
	$Control.visible = true
#	var new_node = demo_list.duplicate(4)
#	list_container.add_child(new_node)
#	new_node.get_node("new_card_name").connect("text_entered",new_node,"_on_new_card_name_text_entered")
#	new_node.demo_card = $card


func _on_LineEdit_text_entered(new_text):
	$Control/LineEdit.text = ""
	$Control.visible = false
	var new_node = demo_list.duplicate(4)
	list_container.add_child(new_node)
	new_node.set_owner(list_container)
	new_node.get_node("detail").text = new_text
	new_node.get_node("new_card_name").connect("text_entered",new_node,"_on_new_card_name_text_entered")
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
		new_node.set_owner(list_container)
		new_node.get_node("detail").text = $Control/LineEdit.text
		new_node.get_node("new_card_name").connect("text_entered",new_node,"_on_new_card_name_text_entered")
		new_node.demo_card = $card
		$Control/LineEdit.text = ""
