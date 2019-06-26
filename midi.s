# Sound mips test #

li	$a0, 60		# Pitch
li	$a1, 1000	# Millisconds
li	$a2, 98		# Instrument
li	$a3, 100	# Volume
la	$v0, 31		# Play MIDI
syscall
# Instrument 98 to right choice
# Instrument 125 to lose