# Digital Timer Watch
extends Node2D

# 0 = hide
# 1 = show
# bit number input supply

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

# time variable

var ms := 0
var second := 0
var second_2 := 0
var minute := 0
var minute_2 := 0
var hour := 0
var hour_2 := 0

var ms_limit := 60

# display bit path
onready var display_1 := $DsiplayBit1
onready var display_2 := $DsiplayBit2
onready var display_3 := $DsiplayBit3
onready var display_4 := $DsiplayBit4
onready var display_5 := $DsiplayBit5
onready var display_6 := $DsiplayBit6

# button star and reset
enum state{START = 1, STOP = 2, RESET = 3}
var app_state := 2

var button_state := false

func _ready() -> void:
	display_1.set_display_unit(ZERO)
	display_2.set_display_unit(ZERO)
	display_3.set_display_unit(ZERO)
	display_4.set_display_unit(ZERO)
	display_5.set_display_unit(ZERO)
	display_6.set_display_unit(ZERO)

func _physics_process(delta: float) -> void:
	
	if app_state == state.STOP:
		return
	if app_state == state.START:
		timer_main()

func timer_main():
	ms += 1
	if ms > ms_limit:
		second += 1
		display_value_loop(second, display_1)
		ms = 0
		if ms_limit >= 15:
			play_sound()
	
	if second > 9:
		display_1.set_display_unit(ZERO)
		second_2 += 1
		display_value_loop(second_2, display_2)
		second = 0
	
	if second_2 > 5:
		display_2.set_display_unit(ZERO)
		minute += 1
		display_value_loop(minute, display_3)
		second_2 = 0
		if ms_limit < 15:
			play_sound()
	
	if minute > 9:
		display_3.set_display_unit(ZERO)
		minute_2 += 1
		display_value_loop(minute_2, display_4)
		minute = 0
	
	if minute_2 > 5:
		display_4.set_display_unit(ZERO)
		hour += 1
		display_value_loop(hour, display_5)
		minute_2 = 0
		play_sound()
	
	if hour > 9:
		display_5.set_display_unit(ZERO)
		hour_2 += 1
		display_value_loop(hour_2, display_6)
		hour = 0
	
	if hour_2 == 2 and hour > 3:
		display_5.set_display_unit(ZERO)
		reset_time()

func reset_time():
	display_1.set_display_unit(ZERO)
	display_2.set_display_unit(ZERO)
	display_3.set_display_unit(ZERO)
	display_4.set_display_unit(ZERO)
	display_5.set_display_unit(ZERO)
	display_6.set_display_unit(ZERO)
	
	ms = 0
	second = 0
	second_2 = 0
	minute = 0
	minute_2 = 0
	hour = 0
	hour_2 = 0
	
	button_state = false

func display_value_loop(p_time, p_node):
	if p_time == 1:
		p_node.set_display_unit(ONE)
	if p_time == 2:
		p_node.set_display_unit(TWO)
	if p_time == 3:
		p_node.set_display_unit(THREE)
	if p_time == 4:
		p_node.set_display_unit(FOUR)
	if p_time == 5:
		p_node.set_display_unit(FIVE)
	if p_time == 6:
		p_node.set_display_unit(SIX)
	if p_time == 7:
		p_node.set_display_unit(SEVEN)
	if p_time == 8:
		p_node.set_display_unit(EIGHT)
	if p_time == 9:
		p_node.set_display_unit(NINE)

func play_sound():
	$AudioStreamPlayer.play()

func _on_StartButton_pressed() -> void:
	
	button_state = !button_state
	if button_state == true:
		$StartButton.text = "PAUSE"
		app_state = state.START
	if button_state == false:
		$StartButton.text = "RESTART"
		app_state = state.STOP

func _on_ResetButton_pressed() -> void:
	app_state = state.STOP
	$StartButton.text = "START"
	reset_time()


func _on_OptionButton_item_selected(index: int) -> void:
	if index == 0:
		ms_limit = 60
	if index == 1:
		ms_limit = 30
	if index == 2:
		ms_limit = 15
	if index == 3:
		ms_limit = 0.8


func _on_VSlider_value_changed(value: float) -> void:
	$AudioStreamPlayer.volume_db = value
