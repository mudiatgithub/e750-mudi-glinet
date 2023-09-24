#!/bin/sh
uci add system button
uci set system.@button[-1].button="BTN_0"
uci set system.@button[-1].action="pressed"
uci set system.@button[-1].handler="/bin/sh /root/genbssid.sh && /usr/bin/wifionoff && /usr/bin/wifionoff"
uci add system button
uci set system.@button[-1].button="BTN_0"
uci set system.@button[-1].action="released"
uci set system.@button[-1].handler="/bin/sh /root/genbssid.sh && /usr/bin/wifionoff && /usr/bin/wifionoff"
uci commit system
