extends KinematicBody2D
class_name Duck



var velocity: Vector2
onready var texture: AnimatedSprite = $texture
onready var movement_timer: Timer = $movement_timer
onready var animation_timer: Timer = $animation_timer
onready var dead_timer: Timer = $dead_timer
onready var duck_sfx: AudioStreamPlayer2D = $duck_sfx
onready var quack_timer: Timer = $quack_timer
export(int) var side
export(int) var speed
export(int) var fall


func _ready() -> void:
  randomize()
  quack_timer.wait_time = rand_range(0.8, 2)
  movement_timer.wait_time = rand_range(0.4, 2)
  animation_timer.wait_time = rand_range(0.6, 1)
  
  
func _process(delta: float) -> void:
  position.x += speed * side * delta
  position.y -= (speed + 40) * fall * delta
  verify_direction()


func verify_direction() -> void:
  if side < 0:
    texture.flip_h = true
  else:
    texture.flip_h = false


func kill() -> void:
  texture.animation = 'scare'
  dead_timer.start()


func _on_movement_timer_timeout() -> void:
  side = side * (-1)


func _on_animation_timer_timeout() -> void:
  if texture.animation == 'up':
    texture.animation = 'side'
  elif texture.animation == 'side':
    texture.animation = 'up'


func _on_dead_timer_timeout() -> void:
  quack_timer.stop()
  texture.animation = 'dead'
  fall = -1
  side = 0


func _on_quack_timer_timeout() -> void:
  duck_sfx.play()
