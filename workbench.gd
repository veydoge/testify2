extends CanvasLayer

var currentItem = 0
var select = 0
@onready var inventory = preload("res://assets/inventory/inventory.tres")
@onready var wb = preload("res://assets/workbrench/WorkBenchTres.tres")

func _ready():
	wb.update_current_item_index(0)
	showItem()
	
func _on_closebtn_pressed():
	get_node("AnimationPlayer").play("TrainOut")
	get_tree().paused = false
	wb.update_current_item_index(0)
	showItem()

func showItem():
	get_node("Control/Sprite2D").texture = wb.get_current_item().texture
	get_node("Control/Name").text = wb.get_current_item().name
	get_node("Control/Des").text = wb.get_current_item().description
	get_node("Control/Des").text += "\n Цена: " + str(wb.get_current_item().cost)
	
func _on_next_pressed():
	if (wb.currentItemIndex == wb.items.size() - 1):
		wb.update_current_item_index(0)
	else:
		wb.update_current_item_index(wb.currentItemIndex + 1)
	showItem()

func _on_prev_pressed():
	if (wb.currentItemIndex == 0):
		wb.update_current_item_index(wb.items.size() - 1)
	else:
		wb.update_current_item_index(wb.currentItemIndex - 1)
	showItem()

func _on_buy_pressed():
	inventory.insert(wb.get_current_item().inventoryItem)
