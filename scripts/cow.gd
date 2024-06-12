extends CharacterBody2D

const SPEED := 20.0
const INERTIA := 0.9

@onready var sprite := $Sprite2D
@onready var anim_tree := $AnimationTree
@onready
var state_mach: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
@onready var intr_area: InteractionArea = $InteractionArea
@onready var moo_label: Label = $MooLabel

var moving = randf() > 0.5
var curr_dir := Vector2.ZERO
var next_at := 0


func _ready():
	intr_area.interact = Callable(self, "_on_interact")


func _physics_process(_delta):
	velocity = velocity.lerp(curr_dir * SPEED, 1 - INERTIA)
	move_and_slide()

	if Time.get_ticks_msec() > next_at:
		if moving:
			moving = false
			curr_dir = Vector2.ZERO
			next_at = Time.get_ticks_msec() + randi_range(5000, 10_000)
		else:
			moving = true
			curr_dir = Vector2(randi_range(-1, 1), randi_range(-1, 1)).normalized()
			sprite.flip_h = curr_dir.x < 0
			moo_label.horizontal_alignment = (
				HORIZONTAL_ALIGNMENT_LEFT if sprite.flip_h else HORIZONTAL_ALIGNMENT_RIGHT
			)
			next_at = Time.get_ticks_msec() + randi_range(1000, 4000)

	if moving:
		state_mach.travel("walk")
	else:
		state_mach.travel("idle")


func _on_interact():
	moo_label.visible = true
	await get_tree().create_timer(2).timeout
	moo_label.visible = false
