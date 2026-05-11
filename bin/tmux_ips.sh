INTERFACES=(ppp0 enp0s31f6 wlp1s0)

tmux_status=""

for interface in "${INTERFACES[@]}"
do
  STATUS=$(ip -brief addres show dev "${interface}")
  if [ $? = 0 ]; then
    read -r nic state ipaddress peer peer_ipaddress <<< "${STATUS}"
    if [ "${state}" != "DOWN" ]
      then
        tmux_status="${tmux_status} ${nic}: ${ipaddress}"
      break
    fi
  fi
done

# dummy comment
echo "${tmux_status}"
