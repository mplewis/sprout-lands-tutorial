extends StaticBody2D

@onready var intr_area: InteractionArea = $InteractionArea
@onready var anim_player: AnimationPlayer = $AnimationPlayer

## The name of the item to put in the chest.
@export var item_name: String
## How many items to put in the chest.
@export var count := 1
var item: InventoryManager.Item


func _ready():
	intr_area.interactable = Callable(self, "_interactable")
	intr_area.interact = Callable(self, "_interact")

	if item_name == "":  # we forgot to put something in the chest
		printerr("Chest has no item: %s" % get_path())
		count = 0
		_open()
		return

	item = InventoryManager.to_item[item_name]
	assert(item, "Item not found: %s" % item_name)


func _interactable():
	return count > 0


func _interact():
	InventoryManager.give(item, count)
	count = 0
	_open()


func _open():
	anim_player.active = true
	anim_player.play("open")
