extends CharacterBody2D

@onready var intr_area: InteractionArea = $InteractionArea


func _ready():
	intr_area.interact = Callable(self, "_interact")


func _interact():
	Dialogic.start("demo")
