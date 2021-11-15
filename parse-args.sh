
if case ${1:-} in -h|--help) true;; '') [ $# -eq 0 ];; *) false;; esac; then
	printf %s\\n >&2 \
		"Usage: $o [-Qifvn] SOURCE DEST" \
		"       $o [-Qifvn] SOURCE... DIRECTORY/" \
		"       $o [-Qifvn] [-t DIRECTORY] SOURCE..." \
		"" \
		"   -[ifv]  is passed to command that supports it" \
		"   -n      is passed to ln command (if supported)" \
		"   -t dir  target directory" \
		"program specific:" \
		"   -Q      dont prompt, assume default" \
		"   -V      dont verbose external commands" \
		"   -F      answer yes for action questions, used for scripts" \
		"" \
		"If some of arguments are not supported by buildins commands, edit first few lines of this script" \
	;
	[ $# -ne 0 ]; exit
fi


{ # parse args
to_shift=$#
last_nonarg=''
while :; do # for empty args is already tested in 'Usage'
	case $1 in
		--)
			to_shift=$(( to_shift - 1 ))
			shift
			while [ $to_shift -ne 0 ]; do
				set -- "$@" "$last_nonarg"
				last_nonarg=$1
				to_shift=$(( to_shift - 1 ))
				shift
			done
			break
		;;
		--*) err "long args are not yet supported";;
		-[!-]*)

			OPTIND=1 # reset getopts
			while getopts :fnivt:QVF i; do # todo unmatch --
				case $i in
					f) flag_f=1;;
					n) flag_n=1;;
					i) flag_i=1;;
					v) flag_v=1;;
					t)
						case $flag_t in 1) err "multiple target directories specified"; esac
						case $(( to_shift - OPTIND + 1 )) in -*) err "option requires an argument -- t"; esac
						flag_t=1; target_d=$OPTARG
					;;
					Q) flag_Q=1;;
					V) flag_V=1;;
					F) flag_F=0;;
					:) err "option requires an argument -- ${OPTARG:?}";;
					?) err "Illegal option -${OPTARG:?}"
				esac
				case $(( to_shift - OPTIND + 1 )) in
					[1-9]*) ;;
					0) break;;
					*) err "err parsing args" 4;;
				esac

			done
			case $? in
				0|1) ;;
				2|*) exit;;
			esac

			to_shift=$(( to_shift - OPTIND + 1 ))
			{ # test if getopts got to '--'
			shift $(( OPTIND - 2 )) || err "err parsing args" 2
			case $1 in --) to_shift=$(( to_shift + 1 )); continue; esac
			shift || err "err parsing args" 6
			}
			case $to_shift in -*) err "err parsing args" 3;; 0) break; esac
			continue
		;;
		*) set -- "$@" "$last_nonarg"; last_nonarg=$1;;
	esac
	to_shift=$(( to_shift - 1 ))
	shift || err "err parsing args" 5
	case $to_shift in 0) break; esac
done
shift $(( to_shift + 1 )) || err "err parsing args" 7 # +1 for missed last_nonarg
case $flag_t in
	1) set -- "$@" "$last_nonarg";;
	*) target=$last_nonarg;;
esac
#unset last_nonarg
#unset to_shift
}

case $flag_Q:$flag_i in 1:1) warn "using contradictory arguments -Q and -i at the same time"; esac
