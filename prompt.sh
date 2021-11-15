
prompt() {
	# arg1 is 2 characters, for example: 'y0' default answer is 'y'
	# and if error or non '[YyNn]*' answer given will return status 0.
	# When flag_Q retrun status is always the fallback 


	case $flag_Q in 1) return "${1#?}"; esac


	case $1 in
		y*) prompt_yn='[Y/n]';;
		n*) prompt_yn='[y/N]';;
		*) prompt_yn='[y/n]';;
	esac
	(
IFS='
' # concat $* using new line
		shift
		printf %s "$* $prompt_yn " >&2
	)

	respond=_
	read respond || return "${1#?}"

	case ${respond:-$1} in
		[Yy]*) return 0;;
		[Nn]*) return 1;;
		*) return "${1#?}";;
	esac
}
main_prompt() {
	prompt y$flag_F "$@" || case $? in
		1) false;;
		3|*) err_code prompt;;
	esac
}
