# AUR4 stuff for making like easier with yaourt.
# Just set the AURURL variable to point to aur4.archlinux.org

alias aur4enable='sudo sed "s/^\#AURURL=\"https:\/\/aur4/AURURL=\"https:\/\/aur4/" -i /etc/yaourtrc'
alias aur4disable='sudo sed "s/^AURURL=\"https:\/\/aur4/\#AURURL=\"https:\/\/aur4/" -i /etc/yaourtrc'
alias aur4status='if [ $(grep "#AURURL=\"https:\/\/aur4" /etc/yaourtrc) ]; then echo Off; else echo On; fi'
