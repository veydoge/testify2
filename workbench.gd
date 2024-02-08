extends CanvasLayer

class_name Workbench

var isWorkbenchOpen = false

@onready var inventory = preload("res://assets/inventory/inventory.tres")
@onready var wb = preload("res://assets/workbrench/WorkBenchTres.tres")


func _ready():
	wb.update_current_item_index(0)
	showItem()
	
func _on_closebtn_pressed():
	get_node("AnimationPlayer").play("TrainOut")
	get_tree().paused = false
	isWorkbenchOpen = false
	wb.update_current_item_index(0)
	showItem()

func showItem():
	get_node("Control/Sprite2D").texture = wb.get_current_item().texture
	get_node("Control/Title").text = wb.get_current_item().name
	get_node("Control/Des").text = wb.get_current_item().description
	get_node("Control/Resource").text = str(wb.get_current_item().resource).replace("{", "").replace("}", "").replace("\"", "")
	
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
	var dic = wb.get_current_item().resource
	var hasAllResources
	for key in dic:
		var value = dic[key]
		for item in inventory.slots:
			hasAllResources = true
			var it = item.item
			var resource
			var count = item.amount
			
			if it == null:
				get_node("Control/Title").text = "Нет ресурсов"
			else:
				resource = it.name
			
			if key == resource && value <= count:	
				hasAllResources = false
				item.amount -= value
				if item.amount == 0:
					inventory.remove_item(it)
				break

	if !hasAllResources:
		inventory.insert(wb.get_current_item().inventoryItem)
