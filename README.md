# xenserver-agent
xenserver snmp custom agent

extend xenserver-status /bin/sh /etc/snmp/xenserver-status.sh
extend xenserver-host /bin/sh /etc/snmp/xenserver-host.sh
extend xenserver-vms /bin/sh /etc/snmp/xenserver-vms.sh
