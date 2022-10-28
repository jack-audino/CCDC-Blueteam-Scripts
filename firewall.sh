#!/bin/bash

# AUTHORS:
# Smash (https://github.com/smash8tap)
# Jack Audino (https://github.com/Jack-Audino)

if [ "$EUID" -ne 0 ]; then
    echo "[!] Must run as superuser"
    exit
fi

# # Get input for services to allow through
# echo -ne "[?] Enter services to allow through\n(separate with comma and specify incoming, outgoing, new or established in parenthesis)\n> "
# read services

# # Get input for which ports to leave open
# echo -ne "[?] Enter ports to allow open:\n(separate with comma and specify incoming, outgoing, new or established in parenthesis)\n> " 
# read ports

# # Get input for which firewall command to use
# echo -ne "[?] Enter firewall command to use (iptables or firewalld) > "
# read firewall_type

echo -ne "[?] Enter firewall type, port and (direction) > "
read input

type=$(echo $input | awk -F ',' '{print $1}')
port=$(echo $input | awk -F ',' '{print $2}')
direction=$(echo $input | awk -F ',[():]' '{print $3}')

# only using to write accept rules, so no need to ask for accept/deny

iptables -t mangle -F
iptables -t mangle -X
iptables -F
iptables -X
    
if [[ $type == *("iptables")* ]]; then
    echo "rules:"
    echo "iptables -t mangle -P $direction -j ACCEPT --dport $port"
    #iptables -t mangle -P $direction -j ACCEPT --dport $port 
fi
# run_iptables() {
#     echo "[+] > Flushing tables"
#     iptables -t mangle -F
#     iptables -t mangle -X
#     iptables -F
#     iptables -X

#     echo "[+] > Applying Default Accept"
#     iptables -t mangle -P INPUT -j ACCEPT
#     iptables -t mangle -P OUTPUT -j ACCEPT

#     # add rules between default accept and default deny
#     echo "  > TEST"
#     
#     
#     
#     for i in $(echo $services | sed "s/,//g")
#     do
#         if [[ $i == *"(incoming)"* ]]; then
#             echo "$i"
#             # create rule based on service

#         elif [[ $i == *"(outgoing)"* ]]; then
#             echo "$i"
#             # create rule based on service

#         elif [[ $i == "" ]]
#         fi
#     done
#     
#     echo "[+] > Applying Default Deny: Connection may drop"
#     iptables -t mangle -A INPUT -j DROP
#     iptables -t mangle -A OUTPUT -j DROP

#     echo "[+] > Sleep Initiated: Cancel Program to prevent flush"
#     sleep 3
#     iptables -t mangle -F

#     echo "[+] > Anti-Lockout executed: Rules have been flushed"
# }


# if [ "$firewall_type" == "iptables" ]; then
#     echo "[+] > Running rules using iptables"
#     run_iptables

# elif [ "$firewall_type" == "firewalld" ]; then
#     echo "[+] > Running rules using firewalld"
#     run_firewalld

# else 
#     echo "[+] > Firewall command not recognized. Quitting..."
# fi 
