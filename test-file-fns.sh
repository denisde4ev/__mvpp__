
file_type() {
	[ -L "$1" ] && { echo l; return; }
	[ -e "$1" ] || { echo z; return 1; }
	if [ -f "$1" ]; then
		echo f
	elif [ -d "$1" ]; then
		echo d
	else
		echo .
	fi
}

does_not_exist() {
	! [ -e "$1" ]
}

# is_empty_dir() {
# 	[ -d "$1" ] && \
# 	set -- "$1"/* && \
# 	[ ! -e "$1" ]
# }
# 
# is_not_empty_dir() {
# 	[ -d "$1" ] && \
# 	set -- "$1"/* && \
# 	[ -e "$1" ]
# }
