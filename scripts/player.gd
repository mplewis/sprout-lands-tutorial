extends CharacterBody2D

const SPEED := 150.0
const INERTIA := 0.7

@onready var player_anim: AnimationTree = $AnimationTree
@onready var dagger: Node2D = $DaggerPosition/Dagger
@onready var dagger_anim: AnimationPlayer = $DaggerPosition/Dagger/AnimationPlayer
@onready
var state_mach: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")

## Whether the player is in the middle of a conversation.
var talking := false


func _ready():
	Dialogic.timeline_started.connect(func(): talking = true)
	Dialogic.timeline_ended.connect(func(): talking = false)
	dagger.visible = false


func _input(event):
	if event.is_action_pressed("ui_attack"):
		_attack()


func _physics_process(_delta):
	var in_dir := Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	if talking:
		in_dir = Vector2.ZERO
	velocity = velocity.lerp(in_dir.normalized() * SPEED, 1 - INERTIA)
	move_and_slide()

	var inputing := in_dir != Vector2.ZERO
	var moving := velocity.length() > 1

	if inputing:
		player_anim.set("parameters/idle/blend_position", in_dir)
		player_anim.set("parameters/walk/blend_position", in_dir)

	if moving:
		state_mach.travel("walk")
	else:
		state_mach.travel("idle")


func _attack():
	dagger.visible = true
	dagger_anim.play("attack")
	print("attack")
