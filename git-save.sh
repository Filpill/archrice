#!/bin/sh
echo "--------------------------------"
echo "Pushing Config Changes to Github"
echo "--------------------------------"

git add .
msg="updating config files `date`"
if [ $# -eq 1 ]
	then msg="$1"
fi
git commit -m "$msg"
git push origin main
