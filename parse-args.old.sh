
# {
#	# get $target
#	# not needed arymore, because of $last_nonarg
#
#	case ${flag_t}${target_} in '') 
#		target_=1
#		if [ $# -lt 2 ]; then
#			err "use -h for usage"
#		elif [ $# -eq 2 ]; then
#			target=$2
#			set -- "$1"
#		# WARNING: shell detection
#		else case ${BASH_VERSION:-${ZSH_VERSION:-${KSH_VERSION:-}}} in
#			?*)
#				target=${@:$#:1}
#				set -- "${@:1:$#-1}"
#			;;
#			*)
#
#				{
#					# assuming 'busybox ash', but if is 'dash/yash/mksh/posh' then will get syntax error
#					i=$#
#					target="${@:$#*2-2:1}" && \
#					set -- "${@:0:$#*2-3}" && \
#					[ $# -eq $(( i - 1 )) ]
#				} || {
#					err "getting last argument went wrong!"
#				}
#	
#			;;
#		esac; fi
#	;;
#		*) target_='';;
#	esac
# }
