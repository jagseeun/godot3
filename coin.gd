extends Area2D

var screensize = Vector2.ZERO

func pickup():
	$CollisionShape2D.set_deferred("disabled", true)
	var tw=create_tween().set_parallel().set_trans(Tween.TRANS_QUAD)
	#tw.tween_property(self, "scale", scale*3, 0.3)
	tw.tween_property(self, "modulate:a", 0.0, 0.3)
	await tw.finished
	queue_free()
func _ready():
	$Timer.start(randf_range(3,8))
	
# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_timer_timeout() -> void:
	$AnimatedSprite2D.frame=0
	$AnimatedSprite2D.play()



func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("obstacles"):
		position=Vector2(randi_range(0, screensize.x), 
		randi_range(0, screensize.y))
