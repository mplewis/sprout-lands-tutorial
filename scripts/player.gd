extends CharacterBody2D

const SPEED := 150.0
const INERTIA := 0.7

@onready var anim_tree := $AnimationTree
@onready
var state_mach: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")


func _physics_process(_delta):
	var in_dir := Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	velocity = velocity.lerp(in_dir.normalized() * SPEED, 1 - INERTIA)
	move_and_slide()

	var inputing := in_dir != Vector2.ZERO
	var moving := velocity.length() > 1

	if inputing:
		anim_tree.set("parameters/idle/blend_position", in_dir)
		anim_tree.set("parameters/walk/blend_position", in_dir)

	if moving:
		state_mach.travel("walk")
	else:
		state_mach.travel("idle")
