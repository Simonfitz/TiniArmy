extends AnimatedSprite2D

var _dmg: int
@onready var label_dmg: Label = $LabelDmg

func _ready():
	label_dmg.hide()
	play()
	animation_finished.connect(on_animation_finished)

func SetDmg(dmg):
	_dmg = dmg

func _process(delta):
	pass

func on_animation_finished():
	label_dmg.show()
	label_dmg.text = str(_dmg)
	
	animation = "empty"
	
	var tween : Tween = get_tree().create_tween()
	tween.parallel().tween_property(self, "scale", Vector2(2,2), 1)
	tween.parallel().tween_property(self, "scale", Vector2(2,2), 1)
	tween.parallel().tween_property(self, "position", Vector2(randi_range(-5, 10), randi_range(-25, -20)), .3)
	
	tween.finished.connect(tween_finished)

func tween_finished():
	queue_free()
