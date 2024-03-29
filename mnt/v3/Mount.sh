#!/bin/bash
case ${BASH_SOURCE:+x} in '')
case $1 in -x) set -x; shift; esac
set -eu
esac
O=${BASH_SOURCE-$0}
o=$O
o=${o##*/}
o=${o%.sh}
o=${o%_}
case $o in
Mount.sh|Mount)
###	case $1 in --help)
###	printf %s\\n \
###		"Usage: $o /dev/mount-point" \
###		"will create symlink with that name" \
###		"in basedir of the script and execute it" \
###	;
###	exit
###	esac
###	cd "${0%/*}" ||exit
###	ln -sn -- "$o" "$1"
###	"./$@"
###	exit
;; *)

	# case ${USER:-$(id -un)} in root) ;; *) mount() { sudo \mount "$@"; }; esac
	# uhh, my mount is alias that breaks this ....

	unset d
	case $o in
		*=*) d=/dev/disk/by-${o%%=*}/${o#*=};;
		*) d=/dev/$o;;
	esac
	diskdir=${O%/*}/$o.d
	mount -v -- "$d" "$diskdir"
	cd -- "$diskdir"


	# ${BASH_SOURCE:+return}
	return; exit
exit; esac

case ${1-} in --help) printf %s\\n "Usage: $o <NEW LINK TO MOUNT>"; exit; esac
case ${1-} in
-*) printf %s\\n >&2 "do not use path with '-' at begining at name"; exit 2;;
'') printf %s\\n >&2 "see --help for usage"; exit 2;;
esac


case $1 in
	/dev/disk/by-*) d=${1#*-}; d=${d%%/*}=${d#*/};;
	/did/*) d=id=${1##*/};;
	*) d=${1##*/};;
esac

# arg "$d"; return ; exit

l=$(realpath -L --relative-to="$PWD" -- "$O") || exit
arg "l=$l" "d=$d" >&2
ln -vsn -- "$l" "$d"
mkdir -v -- "$d.d"
