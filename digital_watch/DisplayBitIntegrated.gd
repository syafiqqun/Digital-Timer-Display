extends Node2D

func set_display_unit(bit_array):
	_set_display_bit_visible(bit_array, $Top, 0, 1)
	_set_display_bit_visible(bit_array, $Mid, 1, 1)
	_set_display_bit_visible(bit_array, $Bot, 2, 1)
	_set_display_bit_visible(bit_array, $TopLeft, 3, 1)
	_set_display_bit_visible(bit_array, $TopRight, 4, 1)
	_set_display_bit_visible(bit_array, $BotLeft, 5, 1)
	_set_display_bit_visible(bit_array, $BotRight, 6, 1)

func _set_display_bit_visible(p_array, p_node, el, value_compare):
	if p_array[el] == value_compare:
		p_node.show()
	else:
		p_node.hide()
