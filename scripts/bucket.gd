extends Area2D

@onready var clang: Label = $Clang


func _physics_process(_delta):
	var areas = get_overlapping_areas()
	for area in areas:
		print(area, area.visible)
	var collide = areas.filter(func(x): return x.visible)
	clang.visible = collide.size() > 0
