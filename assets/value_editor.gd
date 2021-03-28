extends Control

var node_to_be_edited 

func _ready():
	pass





func _on_done_pressed():
	node_to_be_edited.text = $LineEdit.text
	$LineEdit.text = ""
	visible = false


func _on_cancel_pressed():
	visible = false


func _on_LineEdit_text_entered(new_text):
	node_to_be_edited.text = new_text
	$LineEdit.text = ""
	visible = false
