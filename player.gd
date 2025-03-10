extends Area2D

signal pickup ## 동전에 닿았을 때 발신할 시그널
signal hurt ## 장애물에 닿았을 때 발신할 시그

@export var speed = 350
var velocity = Vector2.ZERO
var screensize = Vector2(480, 720)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# 플레이어의 입력을 나타내는 벡터를 구한 다음
	# 화면 안에서 이동하고 경계선을 넘지 못하게 자른다 
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	position += velocity*speed*delta
	
	position.x=clamp(position.x, 0, screensize.x)
	position.y=clamp(position.y, 0, screensize.y)
	
	# 어느 애니메이션을 플레이 할 지 고른다.
	if velocity.length()>0:
		$AnimatedSprite2D.animation="run"
	else:
		$AnimatedSprite2D.animation="idle"
	if velocity.x!=0:
		$AnimatedSprite2D.flip_h=velocity.x<0
		
		
func start():
	# 이 함수는 새 게임을 시작할 때 플레이어를 재설정한다.
	set_process(true)
	position=screensize/2
	$AnimatedSprite2D.animation="idle"
	
func die():
	# 플레이어가 죽으면 이 함수를 호출한다.
	$AnimatedSprite2D.animation="hurt"
	set_process(false)


func _on_area_entered(area):
	# 오브젝트에 닿으면, 무엇을 할지 결정한다.
	if area.is_in_group("coins"):
		area.pickup()
		pickup.emit("coin")
		
	if area.is_in_group("powerups"):
		area.pickup()
		pickup.emit("powerup")
		
	if area.is_in_group("obstacles"):
		hurt.emit()
		die()
		
