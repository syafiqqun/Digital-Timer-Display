extends Node2D


# 0 = hide
# 1 = show

const ZERO := [1, 0, 1, 1, 1, 1, 1]
const ONE := [0, 0, 0, 0, 1, 0, 1]
const TWO := [1, 1, 1, 0, 1, 1, 0]
const THREE := [1, 1, 1, 0, 1, 0, 1]
const FOUR := [0, 1, 0, 1, 1, 0, 1]
const FIVE := [1, 1, 1, 1, 0, 0, 1]
const SIX := [1, 1, 1, 1, 0, 1, 1]
const SEVEN := [1, 0, 0, 0, 1, 0, 1]
const EIGHT := [1, 1, 1, 1, 1, 1, 1]
const NINE := [1, 1, 1, 1, 1, 0, 1]

var time_test := 0
var minute := 0

func _ready() -> void:
	set_display_unit(ZERO)

func _physics_process(delta: float) -> void:
	
	time_test += 1
	if time_test > 30:
		minute += 1
		time_test = 0
	
	if minute > 9:
		set_display_unit(ZERO)
		minute = 0
	
	if minute == 1:
		set_display_unit(ONE)
	if minute == 2:
		set_display_unit(TWO)
	if minute == 3:
		set_display_unit(THREE)
	if minute == 4:
		set_display_unit(FOUR)
	if minute == 5:
		set_display_unit(FIVE)
	if minute == 6:
		set_display_unit(SIX)
	if minute == 7:
		set_display_unit(SEVEN)
	if minute == 8:
		set_display_unit(EIGHT)
	if minute == 9:
		set_display_unit(NINE)

func set_display_unit(bit_array):
	set_display_bit_visible(bit_array, $Top, 0, 1)
	set_display_bit_visible(bit_array, $Mid, 1, 1)
	set_display_bit_visible(bit_array, $Bot, 2, 1)
	set_display_bit_visible(bit_array, $TopLeft, 3, 1)
	set_display_bit_visible(bit_array, $TopRight, 4, 1)
	set_display_bit_visible(bit_array, $BotLeft, 5, 1)
	set_display_bit_visible(bit_array, $BotRight, 6, 1)

func set_display_bit_visible(p_array, p_node, el, value_compare):
	if p_array[el] == value_compare:
		p_node.show()
	else:
		p_node.hide()
