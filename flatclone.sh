#!/bin/bash

while getopts 'cbu:' OPTION; do
	case "$OPTION" in
		u) 
		 URL="$OPTARG"
		 echo "URL is ${URL}"
		 git clone $URL
		 dirname=`echo ${URL} | grep -Eo "<p? pikeminnow>/([^.]+)"`
		 dirname=`echo ${URL} | grep -Eo "/([^.]+)"`
		 echo "New Directory should be ${dirname:1}"
		 dirname="${dirname:1}"
		 ;;
		c)
		 CYES=1
		 ;;
		b)
		 BYES=1
		 ;;
		?)
		echo "flatclone usage: -u [repo ssh clone link] -b open browser -c open vscode">&2
		exit 1
		;;
	esac
done
shift "$(($OPTIND -1))"

if [[ $CYES == 1 ]]; then
	echo "changing to ${dirname}"
	cd "${dirname}"
	code .
fi
if [[ $BYES == 1 ]]; then
	cd "${dirname}"
	explorer.exe index.html
fi

echo "cd ${dirname}"
