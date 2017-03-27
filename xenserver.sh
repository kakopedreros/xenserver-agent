#!/bin/sh

#xenserver SNMP custom agent

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

# VMs on Host

vm_host=$(xe vm-list resident-on=$host_uuid --minimal)

IFS=,
array_vm=($vm_host)

for key in "${!array_vm[@]}"
do
	echo vm$key: $(xe vm-param-get uuid="${array_vm[$key]}" param-name=name-label)
	echo vm$key: $(xe vm-param-get uuid="${array_vm[$key]}" param-name=VCPUs-number)
	echo vm$key: $(xe vm-param-get uuid="${array_vm[$key]}" param-name=VCPUs-utilisation --minimal)
  echo vm$key: $(xe vm-param-get uuid="${array_vm[$key]}" param-name=memory-actual)
  echo vm$key: $(xe vm-param-get uuid="${array_vm[$key]}" param-name=power-state)
  echo vm$key: $(xe vm-param-get uuid="${array_vm[$key]}" param-name=os-version)
	echo vm$key: $(xe vm-param-get uuid="${array_vm[$key]}" param-name=networks)
	echo ''
done
