extends Node

## A type of item the player can possess.
enum Item {
	COIN,
	GRAIN,
}

## The player's inventory.
var _inv: Dictionary = {
	Item.COIN: 0,
	Item.GRAIN: 2,
}


## True if the inventory has at least n items, false otherwise.
func has(item: Item, n: int) -> bool:
	return _inv[item] >= n


## Add n items to the inventory.
func give(item: Item, n: int) -> void:
	_inv[item] += n


## Attempt to remove n items from the inventory. True if successful, false otherwise.
func take(item: Item, n: int) -> bool:
	if !has(item, n):
		return false
	_inv[item] -= n
	return true
