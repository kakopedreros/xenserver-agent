#!/bin/sh

#xenserver SNMP custom agent, using XenAPI

# Host UUID

host_uuid=$(xe host-list name-label=$HOSTNAME --minimal)

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
done
