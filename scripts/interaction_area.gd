extends Area2D
class_name InteractionArea

## The name of the action shown to the player
@export var action_name := "interact"

## Call this to interact with this entity.
var interact: Callable = func():
	pass # Override me


## Register with the InteractionManager when the player enters this area.
func _on_body_entered(_body: Node2D):
	InteractionManager.register(self)

## Deregister from the InteractionManager when the player exits this area.
func _on_body_exited(_body: Node2D):
	InteractionManager.deregister(self)
