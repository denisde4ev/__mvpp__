
case $flag_V in
	1) v(){ "$@"; };;
	*) v() { (PS4=' \$ ';set -x; "$@") };;
esac

mkdir_() { v mkdir ${flag_v:+$mkdir_supports_v} "$@"; }
rmdir_() { v rmdir ${flag_v:+$rmdir_supports_v} "$@"; }
rm_()    { v rm                  ${flag_i:+$rm_supports_i} ${flag_f:+$rm_supports_f} ${flag_v:+$rm_supports_v} "$@"; }
mv_()    { v mv                  ${flag_i:+$mv_supports_i} ${flag_f:+$mv_supports_f} ${flag_v:+$mv_supports_v} "$@"; }
ln_()    { v ln                  ${flag_i:+$ln_supports_i} ${flag_f:+$ln_supports_f} ${flag_v:+$ln_supports_v} "$@"; }
cp_()    { v cp                  ${flag_i:+$cp_supports_i} ${flag_f:+$cp_supports_f} ${flag_v:+$cp_supports_v} "$@"; }
mvT_()   { v mv  $mv_supports_T  ${flag_i:+$mv_supports_i} ${flag_f:+$mv_supports_f} ${flag_v:+$mv_supports_v} "$@"; }
lnT_()   { v ln  $ln_supports_T  ${flag_i:+$ln_supports_i} ${flag_f:+$ln_supports_f} ${flag_v:+$ln_supports_v} "$@"; }
cpT_()   { v cp  $cp_supports_T  ${flag_i:+$cp_supports_i} ${flag_f:+$cp_supports_f} ${flag_v:+$cp_supports_v} "$@"; }
