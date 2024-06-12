extends Node

@onready var inv_label: Label = $Control/MarginContainer/VBoxContainer/InventoryLabel
@onready var inv_mgr: InventoryManager = get_node("/root/InventoryManager")


func _ready():
	print(inv_label)
	inv_mgr.inventory_changed.connect(_inventory_changed)
	_inventory_changed()


func _inventory_changed():
	var lines = inv_mgr.inv.keys().filter(func(x): return inv_mgr.inv[x] > 0).map(
		func(x): return "%s: %d" % [inv_mgr.names[x], inv_mgr.inv[x]]
	)
	inv_label.text = "\n".join(lines)
