#!/bin/sh

#xenserver SNMP custom agent, using XenAPI

# Host UUID

host_uuid=$(xe host-list name-label=$HOSTNAME --minimal)

# Host Memory

memFree=$(xe host-list uuid=$host_uuid params=memory-free --minimal)
memTotal=$(xe host-list uuid=$host_uuid params=memory-total --minimal)
memUsed=$(($memTotal - $memFree))

echo 'memTotal: '$memTotal
echo 'memUsed: '$memUsed
echo 'memFree: '$memFree

# Host CPU Info

cpu_info=$(xe host-cpu-info uuid=$host_uuid)

IFS=$'\n'
array_cpu_info=($cpu_info)

for key in "${!array_cpu_info[@]}"
do
    IFS=': '
    attr=(${array_cpu_info[$key]})
    printf "${attr[0]}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'; echo : "${attr[1]}"
done

# Host CPU Utilisation

cpu_host=$(xe host-cpu-list host-uuid=$host_uuid --minimal)

IFS=,
array_cpu=($cpu_host)

for key in "${!array_cpu[@]}"
do
    echo cpu$key: $(xe host-cpu-param-get uuid="${array_cpu[$key]}" param-name=utilisation)
done
