# xenserver-agent
xenserver snmp custom agent

https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Deployment_Guide/sect-System_Monitoring_Tools-Net-SNMP-Extending.html

```
extend xenserver-status /bin/sh /etc/snmp/xenserver-status.sh
extend xenserver-host /bin/sh /etc/snmp/xenserver-host.sh
extend xenserver-vms /bin/sh /etc/snmp/xenserver-vms.sh
```
