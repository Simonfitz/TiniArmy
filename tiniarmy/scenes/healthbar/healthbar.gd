class_name HealthBar extends TextureProgressBar

@export var ShowNumber : bool = false
@export var AlignTextRight : bool = false

var _maxValue
var _currentValue

var _last_value = 0
var _was_growing = false
var _tween: Tween
var _grow_tween: Tween
var IsSetup = false

func _ready():
	_last_value = _currentValue if _currentValue != null else 0

func _process(delta):
	if value > _last_value and not _was_growing:
		_was_growing = true
	if value <= _last_value and _was_growing and _grow_tween != null and _grow_tween != null:
		_grow_tween.kill()
	_last_value = value
	$Label.text = str(floorf(_currentValue))
	
func started_growing():
	if not is_inside_tree():
		return
	_grow_tween = create_tween()
	_grow_tween.tween_property(self, "scale", scale * .9, .1)
	_grow_tween.tween_property(self, "scale", scale * 1.1, .1)
	
func Setup(maxValue, startValue):
	_maxValue = maxValue
	_currentValue = maxValue
	max_value = 100
	modulate = Color(1, 1, 1, 1) 
	IsSetup = true
	SetValue(startValue)
	
	if ShowNumber:
		$Label.show()
	else:
		$Label.hide()
	if AlignTextRight:
		$Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	
func SetHP(hp):
	_grow_tween = create_tween()
	_grow_tween.tween_property(self, "scale", scale * .9, .1)
	_grow_tween.tween_property(self, "scale", scale * 1.1, .1)
	
	var targetPercentage = SetValue(hp)
	if targetPercentage < 25:
		modulate = Color(1, .2, .3, 1) 
	else:
		modulate = Color(1, 1, 1, 1) 
		
		
func SetValue(hp):
	if not IsSetup:
		printerr("Setup never called before setting value")
		return
	_tween = create_tween()
	_currentValue = hp
	var targetPercentage = _currentValue * 100 / _maxValue
	_tween.tween_property(self, "value", targetPercentage, .5)
	return targetPercentage
