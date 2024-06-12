extends Node2D

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var label := $Label

## Vertical spacing between the interactable area and the label.
const LABEL_SPACING = -10

## The currently active interactable areas.
var active_areas: Array[InteractionArea] = []
## Whether the player can interact with the current area, or not due to a current ongoing interaction.
var can_interact := true
## The name of the button the player presses to interact.
var input_name := ""


## Register an active interactable area when the player enters it.
func register(area: InteractionArea):
	active_areas.append(area)


## Deregister an interactable area when the player leaves it.
func deregister(area: InteractionArea):
	active_areas.erase(area)


func _ready():
	var interact: InputEvent = InputMap.action_get_events("ui_interact")[0]
	var keycode = DisplayServer.keyboard_get_keycode_from_physical(interact["physical_keycode"])
	input_name = OS.get_keycode_string(keycode)


func _process(_delta):
	var aarea := _active_area()
	if !aarea:
		label.hide()
		return

	if !can_interact:
		return

	label.text = "[%s] to %s" % [input_name, aarea.action_name]
	label.global_position = aarea.global_position - Vector2(label.size.x / 2, LABEL_SPACING)
	label.show()


func _input(event):
	if !event.is_action_pressed("ui_interact"):
		return
	if !can_interact:
		return
	var aarea := _active_area()
	if !aarea:
		return

	label.hide()
	can_interact = false
	await aarea.interact.call()
	can_interact = true


## Get the closest active area to the player, or null if there are none.
func _active_area() -> InteractionArea:
	if active_areas.size() == 0:
		return null
	active_areas.sort_custom(_dist_to_player)
	return active_areas[0]


## Sort interactable areas by distance to the player, ascending.
func _dist_to_player(a: InteractionArea, b: InteractionArea):
	var ploc := player.global_position
	return a.global_position.distance_to(ploc) - b.global_position.distance_to(ploc)
