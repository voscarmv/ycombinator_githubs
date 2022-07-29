echo '['
while read line ; do
    IFS=, read -r -a arr <<< $line
    echo '  {'
    echo '      "issues": '${arr[0]}','
    echo '      "url": "'${arr[1]}'",'
    echo '      "language": "'${arr[2]}'"'
    echo '  },'
done
echo ']'