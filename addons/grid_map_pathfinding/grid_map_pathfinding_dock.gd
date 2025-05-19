extends Control

@onready var title: Label = $VBoxContainer/Title

@onready var item_name: Label = $VBoxContainer/HBoxContainer/ItemName
@onready var item_id: Label = $VBoxContainer/MainContainer2/ItemID

@onready var add_item_id: Button = $VBoxContainer/AddItemID
@onready var info: Label = $VBoxContainer/Info

@onready var cell_pos: Label = $VBoxContainer/HBoxContainer2/CellPos
@onready var local_pos: Label = $VBoxContainer/HBoxContainer3/LocalPos
@onready var mesh_preview: TextureRect = $VBoxContainer/MeshPreview

@onready var add_start_button: Button = $VBoxContainer/HBoxContainer4/AddStart
@onready var add_end_button: Button = $VBoxContainer/HBoxContainer4/AddEnd

func _ready() -> void:
	pass
