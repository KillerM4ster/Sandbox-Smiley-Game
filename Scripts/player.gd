extends CharacterBody2D

@export_category("Movement")
@export_enum("Grid-based", "Platform") var movement_type : String = "Platform"
@export var speed := 256.0
@export var acceleration := 5.0
@export var friction := 10.0
@export var jump_strength := 464.0
@export var gravity := 1536.0
@export var max_fall_speed := 1024.0


func _physics_process(delta: float) -> void:
	if movement_type == "Platform":
		var direction := Input.get_axis("LEFT", "RIGHT")
		
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
