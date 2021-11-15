
if [ -x "$(command -v tput)" ]; then
	bold="$(tput bold)"
	# black="$(tput setaf 0)"
	# red="$(tput setaf 1)"
	# green="$(tput setaf 2)"
	# yellow="$(tput setaf 3)"
	# blue="$(tput setaf 4)"
	# magenta="$(tput setaf 5)"
	cyan="$(tput setaf 6)"
	# white="$(tput setaf 7)"
	reset="$(tput sgr0)"
else
	bold=''
	# black=''
	# red=''
	# green=''
	# yellow=''
	# blue=''
	# magenta=''
	cyan=''
	# white=''
	reset=''
fi

err()  { printf %s\\n "${bold}${o}${reset}: $1" >&2; exit ${2:-1}; }
warn() { printf %s\\n "${bold}${cyan}WARNING${reset}: $@" >&2; }
info() { printf %s\\n "${bold}${cyan}INFO LOG${reset}: $@" >&2; }
err_code() { err "$1 exit code: $?" $?; }
