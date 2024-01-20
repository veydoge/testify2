extends Control

@onready var inventory = preload("res://assets/inventory/inventory.tres") 
@onready var slots: Array = $GridContainer.get_children()

func update():
	for i in range(5):
		slots[i].update(inventory.slots[i])
		
# Called when the node enters the scene tree for the first time.
func _ready():
	inventory.updated.connect(update)	
	update()