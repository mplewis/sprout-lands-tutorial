extends Node

## The player's inventory has changed.
signal inventory_changed

## A type of item the player can possess.
enum Item {
	COIN,
	GRAIN,
}

## Lookup item names by their type.
var to_name := {
	Item.COIN: "Coin",
	Item.GRAIN: "Grain",
}

## Lookup items by their name.
var to_item := {
	"Coin": Item.COIN,
	"Grain": Item.GRAIN,
}

## The player's initial inventory.
var inv := {
	Item.COIN: 0,
	Item.GRAIN: 2,
}


## True if the inventory has at least n items, false otherwise.
func has(item: Item, n: int) -> bool:
	return inv[item] >= n


## Add n items to the inventory.
func give(item: Item, n: int) -> void:
	inv[item] += n
	inventory_changed.emit()


## Attempt to remove n items from the inventory. True if successful, false otherwise.
func take(item: Item, n: int) -> bool:
	if !has(item, n):
		return false

	inv[item] -= n
	inventory_changed.emit()
	return true
