# Some useful bash stuff

# Yaourt shortcuts
alias yaup='yaourt -Syyua'
alias yausl='yaourt -Rs $(yaourt -Qtdq)'
alias yac='yaourt -Sc'

# Cleanup and redownload of all the packages
paccleanup() {
	# Clean up cache
	yaourt -Scc
	# Download packages
	yaourt -Sw $(yaourt -Qqn)
	# AUR part
	yaourt -Sb $(yaourt -Qqm)
}

# See package usage size and biggest packages
alias pacusage="LANG=C pacman -Qi | grep 'Name\|Installed Size\|Description' | cut -d: -f 2 | sed 's/ //' | paste - - - | awk -F'\t' '{print \$3\"\\t\"\$1\"\\t\"\$2 }' | awk '{if (\$2 == \"KiB\") {size = \$1 * 1024} else if (\$2 == \"MiB\") {size = \$1 * 1024 * 1024} else {size = \$1} printf \"%i\\t%s\\n\", size, \$0}' | sort -nr"
