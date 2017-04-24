## Normal stuff
# Behold in front of the best alias!
# Should be a default one everywhere.
alias c='clear'
# Colored ls
alias ls='ls --color=auto'
alias ll='ls -al --color=auto'
# Colored grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

## Tweaked commands with proper options
# Allow less to get colored input
alias less='less -R'
# Nice options for xz
alias xz='xz -evT0'
# What day is today?
alias today='date +%Y-%m-%d'

## Network-related stuff
# I usually don't want to ping forever. 10 times is enough.
alias ping='ping -c 10'
# Checking if I'm online or not
alias imon='ping -c 10 www.google.it'

## Shortcuts to system commands...
# Not available in ArchLinux. So, added an alias for it
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
# Useful for RAM-fs rebuild.
alias update-initramfs='sudo mkinitcpio -p linux'

## Handy shortcuts to user-level applications
# For easy Wine management
alias winecontrol='env WINEPREFIX=~/.wine-pipelight/ /opt/wine-compholio/bin/wine control'
# Good thing for tmux in a tty
alias my_tmux='setterm -blank 0 && tmux'
# Alias to run an higly used Adobe AIR application.
#alias eoloapp='/opt/adobe-air-sdk/bin/adl \
#	-nodebug /opt/airapps/EOLOapp/META-INF/AIR/application.xml \
#	/opt/airapps/EOLOapp/'

## Dirty stuff. Hehe~
# Allows me to fetch VPNBook.com password from CLI. Pretty handy huh?
# Only command line tools involved.
# I made a Python version of this, for Windows.
alias vpnbook-password="curl -sL 'http://vpnbook.com/freevpn' 2>/dev/null \
	| grep --color=none -m1 'Password:' \
	| sed 's/^[[:space:]]*<li>Password: <strong>//' \
	| sed 's/<\/strong><\/li>//'"
	#| grep -m1 --color=none 'Password:' \
	#| sed 's/\s*<li>Password: <strong>//' \
# Handy alias to get battery percentage.
# Adjust the battery info path in /sys to match yours.
BATTERY_PATH="/sys/class/power_supply/BAT1"
alias battery='test -d "$BATTERY_PATH" \
	&& expr \
	\( `cat "$BATTERY_PATH/charge_now"` \* 100 \) / \
	`cat "$BATTERY_PATH"/charge_full` \
	|| echo "Not available"'
# Get network devices status and make it pretty.
# Uses NetworkManager (nmcli).
alias network-status='env LANG=C nmcli -t -f type,state -e yes device \
	| grep -v "loopback" \
	| tr "\n" " " \
	| sed "s/connected/on/g" \
	| sed "s/unavailable/off/g" \
	| sed "s/ $/\n/"'
# Detect if we booted with Secure Boot enabled or not.
# Adjust the /sys path to match yours.
SECURE_BOOT_PATH="/sys/firmware/efi/efivars/SecureBoot-8be4df61-93ca-11d2-aa0d-00e098032b8c"
alias secure-boot="od -An -t u1 $SECURE_BOOT_PATH \
	| sed 's/\s\+/ /g' \
	| cut -d' ' -f6"
