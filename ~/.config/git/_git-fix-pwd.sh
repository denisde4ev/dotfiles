
case ${GIT_FIX_PWD?"git-fix-pwd: missing GIT_FIX_PWD var"} in "$PWD") return; esac

case ${GIT_FIX_PWD__NOERROR:+x} in '') # use `export GIT_FIX_PWD__NOERROR=1` to surpress this warning
	printf %s\\n >&2 \
		"git-fix-pwd WARNING: \$PWD and \$GIT_FIX_PWD differ:" \
		"PWD=$PWD" \
		"GIT_FIX_PWD=$GIT_FIX_PWD" \
	;
esac

cd -- "${GIT_FIX_PWD}"
