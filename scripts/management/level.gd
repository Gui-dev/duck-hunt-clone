extends Node2D
class_name Level

var ducks_on_screen: int
var Duck: PackedScene = preload('res://scenes/duck/duck.tscn')
var flyaway: int = 0
var captured_ducks: int = 0
onready var aim: Area2D = $Aim
onready var spawn_ducks: Timer = $spawn_ducks
onready var spawn_new_ducks: Timer = $spawn_new_ducks
onready var animation: AnimationPlayer = $animation
onready var score: Label = $hud/score
onready var dog_captured_sfx: AudioStreamPlayer2D = $dog_captured_sfx
onready var dog_smiling_sfx: AudioStreamPlayer2D = $dog_smiling_sfx
onready var dead_duck_sfx: AudioStreamPlayer2D = $dead_duck_sfx
onready var duck_flyaway_sfx: AudioStreamPlayer2D = $duck_flyaway_sfx
onready var new_match_sfx: AudioStreamPlayer2D = $new_match_sfx


func _ready() -> void:
  spawn_ducks.start()


func _process(_delta: float) -> void:
  aim.position = get_local_mouse_position()
  score.text = str(captured_ducks)


func duck_generator() -> void:
  var duck = Duck.instance()
  duck.position.x = rand_range(50, 700)
  duck.position.y = 700
  get_tree().root.call_deferred('add_child', duck)


func update_match() -> void:
  if ducks_on_screen == 0:
    spawn_new_ducks.start()
    if flyaway == 1:
      animation.play('dog_smiling')
      dog_smiling_sfx.play()
      flyaway = 0
      captured_ducks = 0
    else:
      animation.play('duck_capture')
      dog_captured_sfx.play()
      


func _on_spawn_ducks_timeout() -> void:
  ducks_on_screen = int(rand_range(1, 6))

  for duck in ducks_on_screen:
    duck_generator()


func _on_spawn_new_ducks_timeout() -> void:
  new_match_sfx.play()
  $spawn_ducks.start()


func _on_top_collision_body_entered(_body: Node) -> void:
  duck_flyaway_sfx.play()
  flyaway = 1
  ducks_on_screen -= 1
  update_match()


func _on_bottom_collision_body_entered(_body: Node) -> void:
  dead_duck_sfx.play()
  captured_ducks += 1
  ducks_on_screen -= 1
  update_match()
