extends Area2D
class_name InteractionArea

## The name of the action shown to the player
@export var action_name := "interact"

## Call this to interact with this entity.
var interact: Callable = func():
	pass # Override me

## If this returns true, the player can interact with this entity.
var interactable: Callable = func():
	return true # Override this to make this entity conditionally interactable

## Override this to show a message when the player cannot interact with this entity.
var non_interactable_message: Callable = func() -> String:
	return ""

## Register with the InteractionManager when the player enters this area.
func _on_body_entered(_body: Node2D):
	print("registered %s" % self)
	InteractionManager.register(self)

## Deregister from the InteractionManager when the player exits this area.
func _on_body_exited(_body: Node2D):
	print("deregistered %s" % self)
	InteractionManager.deregister(self)
