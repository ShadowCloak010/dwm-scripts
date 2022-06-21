#!/bin/bash

_time() {
    echo "`date '+%m/%d %H:%M:%S'`"
}

_memory() {
    memoryStatus=(`free -m |  awk '/^Mem:/{print(int($3/$2*100) "%")}'`)
    echo $memoryStatus

}

_cpu() {
        CPULOG_1=$(cat /proc/stat | grep 'cpu ' | awk '{print $2" "$3" "$4" "$5" "$6" "$7" "$8}')
        SYS_IDLE_1=$(echo $CPULOG_1 | awk '{print $4}')
        Total_1=$(echo $CPULOG_1 | awk '{print $1+$2+$3+$4+$5+$6+$7}')

        sleep 1

        CPULOG_2=$(cat /proc/stat | grep 'cpu ' | awk '{print $2" "$3" "$4" "$5" "$6" "$7" "$8}')
        SYS_IDLE_2=$(echo $CPULOG_2 | awk '{print $4}')
        Total_2=$(echo $CPULOG_2 | awk '{print $1+$2+$3+$4+$5+$6+$7}')

        SYS_IDLE=`expr $SYS_IDLE_2 - $SYS_IDLE_1`
        Total=`expr $Total_2 - $Total_1`
        SYS_Waits=`expr $SYS_IDLE/$Total*100 |bc -l`
        SYS_Rate=`expr 100-$SYS_Waits | bc -l`

        Disp_SYS_Rate=`expr "scale=0; $SYS_Rate/1" | bc`
        echo $Disp_SYS_Rate%
}

_battery() {
    lowBatteryNotice=20
    batteryStatus=(`acpi | sed -nr 's/.+:\s(.+),\s([0-9]{1,3}%).*/\1 \2 /p'`)

    if [[ -z $batteryStatus ]]; then
        dunstify -u critical 'not found battery infomations'
        exit 1
    fi

    case ${batteryStatus[0]} in
        "Charging") icon="∞" ;;
        "Discharging") icon="✗" ;;
        "Not")
            icon="✓"
            batteryStatus[1]="${batteryStatus[2]}"
            ;;
        "*") icon="unknown status: ${batteryStatus[0]}" ;;
    esac

    if ( (( ${batteryStatus[1]%*%} < $lowBatteryNotice )) && [[ ! -f '/tmp/batteryLow' ]] ); then
        dunstify -u critical -t 3600000 'Battery low'
        touch /tmp/batteryLow
    fi

    echo "${batteryStatus[1]}(${icon})"
}


while [[ true ]]; do
    xsetroot -name "$(_cpu)  $(_memory)  $(_time)"
    sleep 1
done

