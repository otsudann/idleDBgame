extends Container

func _notification(what):
	if what == NOTIFICATION_SORT_CHILDREN:
		# Must re-sort the children
		for c in get_children():
			# Fit to own size
			fit_child_in_rect( c, Rect2( Vector2(), rect_size ) )

func set_some_setting():
	# Some setting changed, ask for children re-sort
	queue_sort()

func new_container(title, itemName, quantity, buyPrice, sellPrice):
	var c = GridContainer.new()
	c.set_columns([1,2,3])
	pass
