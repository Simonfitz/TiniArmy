extends Panel

@export var IsPlayerRed = false
@onready var labelPlayer: Label = $LabelPlayer

func _ready() -> void:
	labelPlayer.text = "Red" if IsPlayerRed else "Blue"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
