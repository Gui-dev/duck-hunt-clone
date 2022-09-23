extends Node2D
class_name Level

var ducks_on_screen: int
var Duck: PackedScene = preload('res://scenes/duck/duck.tscn')
var flyaway: int = 0
var captured_ducks = 0
onready var aim: Area2D = $Aim
onready var spawn_ducks: Timer = $spawn_ducks


func _ready() -> void:
  spawn_ducks.start()


func _process(_delta: float) -> void:
  aim.position = get_local_mouse_position()
  print('SAIU: ', flyaway)
  print('CAIU: ', captured_ducks)


func duck_generator() -> void:
  var duck = Duck.instance()
  duck.position.x = rand_range(50, 700)
  duck.position.y = 700
  get_tree().root.call_deferred('add_child', duck)


func _on_spawn_ducks_timeout() -> void:
  ducks_on_screen = int(rand_range(1, 6))

  for duck in ducks_on_screen:
    duck_generator()


func _on_spawn_new_ducks_timeout() -> void:
  $spawn_ducks.start()


func _on_top_collision_body_entered(body: Node) -> void:
  if body.name == 'Duck':
    flyaway = 1
    ducks_on_screen -= 1


func _on_bottom_collision_body_entered(body: Node) -> void:
  if body.name == 'Duck':
    captured_ducks += 1
    ducks_on_screen -= 1
