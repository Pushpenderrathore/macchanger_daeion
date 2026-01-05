#!/bin/bash 

# MAC Address Watcher - Changes MAC address every 5 minutes and on internet reconnection 

VERSION="v1.0.0"
echo "[macchanger-daemon $VERSION] Starting..."

INTERVAL=600  # 5 minutes 
CHECK_HOST="1.1.1.1"  # Cloudflare DNS for connectivity check 
PREV_STATUS=connected 


change_mac() {
     echo "[+] Changing MAC addresses for all network interfaces..."
     interfaces=$(ip -o link show | awk -F': ' '{print $2}' | grep -v lo)
     

     for iface in $interfaces; do
         echo "    ↪ Interface: $iface"
         sudo ip link set "$iface" down        
         sudo macchanger -r "$iface"
         sudo ip link set "$iface" up
         
         
         # 🔽 Log the change
         mac=$(ip link show "$iface" | grep ether | awk '{print $2}') 
         echo "$(date): $iface MAC changed to: $mac" | sudo tee -a /var/log/macchanger.log > /dev/null
     
     done
}

last_change_time=0 

while true; do
     current_time=$(date +%s);
     # Internet connectivity check
     ping -c 1 -W 1 "$CHECK_HOST" &>/dev/null
     if [[ $? -eq 0 ]]; then
         if [[ "$PREV_STATUS" == "disconnected" ]]; then
             echo "[✓] Internet reconnected. Triggering MAC change."
             change_mac
             last_change_time=$current_time
         fi
         PREV_STATUS=connected
     else
         echo "[!] Internet seems disconnected..."
         PREV_STATUS=disconnected
     fi
     

     # Check for interval-based MAC change
     if (( current_time - last_change_time >= INTERVAL )); then
         echo "[⏰] 10-minute interval reached. Triggering MAC change."
         change_mac
         last_change_time=$current_time
     fi
     sleep 1 
done 
