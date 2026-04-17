extends CharacterBody2D

@export_category("Movement")
@export_enum("Platform", "Grid-based") var movement_type : String = "Platform"
@export var speed := 384.0
@export var acceleration := 4.0
@export var friction := 10.0
@export var jump_strength := 464.0
@export var gravity := 1536.0
@export var max_fall_speed := 1024.0
@export var no_clip: bool = false:
	set(value):
		no_clip = value
		collision_shape_2d.disabled = value
		if Global.ui:
			Global.ui.update_no_clip_button()

@export var collision_shape_2d: CollisionShape2D


func _process(delta: float) -> void:
	if no_clip:
		_no_clip_update(delta)
	else:
		match movement_type:
			"Platform":
				_platform_update(delta)
			"Grid-based":
				_grid_based_update(delta)


func _physics_process(delta: float) -> void:
	if no_clip:
		_no_clip_physics_update(delta)
	else:
		match movement_type:
			"Platform":
				_platform_physics_update(delta)
			"Grid-based":
				_grid_based_physics_update(delta)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("NOCLIP"):
		no_clip = not no_clip


func _no_clip_update(_delta: float) -> void:
	pass


func _no_clip_physics_update(delta: float) -> void:
	var direction := Input.get_vector("LEFT", "RIGHT", "UP", "DOWN")
	
	if abs(direction.x) > 0.5:
		direction.x = sign(direction.x)
	else:
		direction.x = 0.0
		
	if abs(direction.y) > 0.5:
		direction.y = sign(direction.y)
	else:
		direction.y = 0.0
	
	if direction == Vector2.ZERO:
		velocity = lerp(velocity, Vector2.ZERO, friction * delta)
	else:
		velocity = lerp(velocity, speed * direction, acceleration * delta)
	
	move_and_slide()


func _platform_update(_delta: float) -> void:
	pass


func _platform_physics_update(delta: float) -> void:
	var direction := Input.get_axis("LEFT", "RIGHT")
	
	if abs(direction) > 0.5:
		direction = sign(direction)
	else:
		direction = 0.0
	
	if direction == 0:
		velocity.x = lerp(velocity.x, 0.0, friction * delta)
	else:
		velocity.x = lerp(velocity.x, speed * direction, acceleration * delta)
	
	if not is_on_floor() and \
	velocity.y < max_fall_speed:
		velocity.y = min(velocity.y + gravity * delta, max_fall_speed)
	
	if Input.is_action_just_pressed("JUMP") and \
	is_on_floor():
		velocity.y = -jump_strength
	
	move_and_slide()


func _grid_based_update(_delta: float) -> void:
	pass


func _grid_based_physics_update(_delta: float) -> void:
	pass
