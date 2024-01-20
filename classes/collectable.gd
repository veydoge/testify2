extends Area2D

@export var itemRes: InventoryItem

@onready var inventory = preload("res://assets/inventory/inventory.tres") 

var isPlayerNear = false

func collect():
	inventory.insert(itemRes)
	queue_free()
