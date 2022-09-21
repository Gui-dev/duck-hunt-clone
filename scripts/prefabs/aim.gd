extends Area2D
class_name Aim


var current_duck = null
onready var sound: AudioStreamPlayer2D = $sound


func _ready() -> void:
  pass
  

func _input(_event: InputEvent) -> void:
  if Input.is_action_just_pressed('ui_shot'):
    sound.play()
    if current_duck == null:
      return
    else:
      current_duck.kill()


func _on_body_entered(body: Node) -> void:
  current_duck = body
