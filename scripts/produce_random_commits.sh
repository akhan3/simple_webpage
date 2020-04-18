#!/bin/bash

if [ $# -eq 0 ]
  then
    n_commits=1
else
    n_commits=$1
fi

for j in `seq $n_commits`
do
    cat <(head -n-7 index.htm) \
        <(
            (
                for k in `seq 5`
                do
                    N=$((20 + $RANDOM % 40))
                    lorem -s $N; echo '<p>'
                done
            )
            echo
            echo '</body></html>'
        ) | sponge index.htm

    # msg=$(lorem -w8 | awk '{print tolower($0)}' | xargs echo)
    msg=$(shuf -n 8 <(grep -v "'" /usr/share/dict/american-english) | awk '{print tolower($0)}' | xargs echo)
    echo $j $msg

    git add index.htm
    git commit -m "$msg"
done


