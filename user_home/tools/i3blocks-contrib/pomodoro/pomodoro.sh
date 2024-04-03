#!/bin/bash

DATE_FIELD="DATE"
STATUS_FIELD="STATUS"
SAVED_TIME_FIELD="SAVED_TIME"
STATE_NOT_STARTED="not_started"
STATE_STOPED="stoped"
STATE_STARTED="started"

store_state(){
    local file=$1
    local state_start_date=$2
    local state_status=$3
    local state_time=$4
    echo "$DATE_FIELD=${state_start_date}" > $file
    echo "$STATUS_FIELD=${state_status}" >> $file
    echo "$SAVED_TIME_FIELD=${state_time}" >> $file
}

read_state(){
    local file=$1
    local -n val=$2
    local DATE=""
    local STATUS=""
    if [ -s $file ]
    then
        while IFS= read -r line
        do
          echo "$line"
          eval "local $line"
        done < "$file"
    else
        echo "ici"
        DATE=$(date '+%s')
        STATUS=$STATE_NOT_STARTED
        SAVED_TIME=""
        echo "$DATE_FIELD=$DATE" > $file
        echo "$STATUS_FIELD=$STATUS" >> $file
    fi

    echo "$DATE_FIELD read state=$DATE"
    echo "$STATUS_FIELD read state=$STATUS"
    echo "$SAVED_TIME_FIELD read state=$SAVED_TIME"
    val=($DATE $STATUS $SAVED_TIME)
}

tmpdir=$(dirname $(mktemp -u))

state_file="$tmpdir/i3-block-pomodoro.state"
touch $state_file

echo "state file : $state_file"

read_state $state_file reply

state_start_date="${reply[0]}"
state_status="${reply[1]}"
state_saved_time="${reply[2]}"



case $button in

  1)
    if [[ $state_status == $STATE_NOT_STARTED ]]
    then 
        echo "starting pomodoro"
        store_state $state_file $(date '+%s') $STATE_STARTED
    elif [[ $state_status == $STATE_STARTED ]]
    then
        echo "pausing pomodoro"
        store_state $state_file $(date '+%s') $STATE_STOPED
    elif [[ $state_status == $STATE_STOPED ]]
    then
        echo "re starting pomodoro"
        store_state $state_file $(date '+%s') $STATE_STARTED
    fi
    ;;
  2)
    ;;
  3)
    echo "reseting pomodoro"
    ;;

  *)
    echo "work : $duree"
    ;;
esac



#cat $state_file

echo "from pomodoro.sh $button"



