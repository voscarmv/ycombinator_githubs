echo '['
while read line ; do
    IFS=, read -r -a arr <<< $line
    ORG=`echo ${arr[1]} | sed 's/.*github.com\///;s/\/.*//'`
    REPO=`echo ${arr[1]} | sed 's/.*\///'`
    echo '  {'
    echo '      "issues": '${arr[0]}','
    echo '      "org": "'${ORG}'",'
    echo '      "repo": "'${REPO}'",'
    echo '      "language": "'${arr[2]}'",'
    echo '      "topics": [' $( printf '"%s", ' "${arr[@]:3}")']'
    echo '  },'
done
echo ']'